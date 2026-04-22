import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/multiplayer/domain/lobby_controller.dart';
import 'package:wisdom_gre_app/features/multiplayer/domain/multiplayer_arena_controller.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/multiplayer/presentation/arena_recap_screen.dart';

class ArenaMultiplayerScreen extends ConsumerStatefulWidget {
  final String duelId;
  final int? hostSelectedDuration;
  final String? hostSelectedMode;

  const ArenaMultiplayerScreen({
    super.key, 
    required this.duelId, 
    this.hostSelectedDuration,
    this.hostSelectedMode,
  });

  @override
  ConsumerState<ArenaMultiplayerScreen> createState() => _ArenaMultiplayerScreenState();
}

class _ArenaMultiplayerScreenState extends ConsumerState<ArenaMultiplayerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _timerController;
  late Animation<double> _pulseAnimation;
  
  Map<String, dynamic>? _fullDatabase;
  bool _isDbLoaded = false;
  int _currentQuestionIndex = 0;
  List<String> _currentOptions = [];
  bool _hasAnsweredCurrent = false;

  int _secondsLeft = 60;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _timerController, curve: Curves.easeInOut),
    );
    
    _loadDatabaseAndInitSeed();
  }

  void _startGameTimer() {
    if (_isTimerRunning) return;
    _isTimerRunning = true;
    _tick();
  }

  void _tick() {
    if (!mounted) return;
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
          _tick();
        } else {
          _endGame();
        }
      });
    });
  }

  void _endGame() {
      final lobbyState = ref.read(lobbyControllerProvider).valueOrNull;
      final me = ref.read(currentUserProvider);
      final arenaState = ref.read(multiplayerArenaControllerProvider(widget.duelId));
      
      // Stop the controller
      _timerController.stop();

      // Force local transition IMMEDIATELY regardless of SQL success (resilience)
      if (mounted) {
         Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (_) => ArenaRecapScreen(
             finalScores: arenaState.scores,
             participants: lobbyState?.participants ?? [],
           ),
         ));
      }

      // Only host cleans up SQL and handles stats
      if (lobbyState != null && me != null && lobbyState.hostId == me.id) {
         Supabase.instance.client.from('duels').update({'status': 'finished'}).eq('id', widget.duelId);
         
         // Phase 7: Stats calculation (Tie Handling)
         final scoresMap = arenaState.scores;
         if (scoresMap.isNotEmpty && lobbyState.participants.length > 1) {
            // Sort by score
            final sortedEntries = scoresMap.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value)); // Max first
            
            final topScore = sortedEntries.first.value;
            final topPlayers = sortedEntries.where((e) => e.value == topScore).map((e) => e.key).toList();
            final otherPlayers = sortedEntries.where((e) => e.value < topScore).map((e) => e.key).toList();
            
            // If absolute winner (only 1 player at the top)
            if (topPlayers.length == 1) {
               final winnerId = topPlayers.first;
               if (otherPlayers.isNotEmpty) {
                 Supabase.instance.client.rpc('record_match_results', params: {
                    'winner_id': winnerId,
                    'loser_ids': otherPlayers,
                 });
               }
            } else {
               // Tie at the top! No winner, but everyone else gets a loss.
               // (Actually, if there are losers, they get a loss)
               if (otherPlayers.isNotEmpty) {
                  // Since record_match_results expects a winner, and we don't have one,
                  // we can either modify the RPC to accept null winner, or just 
                  // do an update directly for the losers if there's no winner.
                  // For simplicity, let's call a direct update or a new RPC.
                  // Or we can just call record_match_results with a dummy winner that won't match,
                  // but that's dirty. Let's do a direct update. Or we can just let the Host update them
                  // Wait, RLS prevents Host from updating others.
                  // I should call record_match_results with a NULL winner_id. Let's pass a dummy UUID that no one has
                  // or just let the RPC handle it if we modify it.
                  // ACTUALLY, if the user ran the RPC exactly as I gave:
                  // UPDATE ... WHERE id = winner_id.
                  // If we pass an empty UUID like '00000000-0000-0000-0000-000000000000', it just updates nothing for the winner,
                  // but updates the losers!
                  Supabase.instance.client.rpc('record_match_results', params: {
                    'winner_id': '00000000-0000-0000-0000-000000000000',
                    'loser_ids': otherPlayers,
                  });
               }
            }
         }
      }
  }

  Future<void> _loadDatabaseAndInitSeed() async {
    try {
      final jsonString = await rootBundle.loadString('gre_database_premium.json');
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      
      if (mounted) {
        setState(() {
          _fullDatabase = data;
          _isDbLoaded = true;
        });

        // If I am the Host, automatically construct and broadcast a seed
        final lobbyState = ref.read(lobbyControllerProvider).valueOrNull;
        final me = ref.read(currentUserProvider);
        if (lobbyState != null && me != null && lobbyState.hostId == me.id) {
           _generateAndBroadcastSeed(data);
        }
      }
    } catch (_) {}
  }

  void _generateAndBroadcastSeed(Map<String, dynamic> db) {
    final words = db.keys.toList();
    words.shuffle();
    final seed = words.take(100).toList(); // Mega-Seed
    final duration = widget.hostSelectedDuration ?? 60;
    final mode = widget.hostSelectedMode ?? 'def_to_word';
    
    // BEACON MODE: The Host blasts the Configuration periodically 
    // to ensure opponents who transition late (or have high latency)
    // catch the seed successfully and do not get stuck on 'Receiving scenario'
    int ticks = 0;
    Timer.periodic(const Duration(seconds: 2), (timer) {
       if (!mounted || ticks >= 5) {
          timer.cancel();
          return;
       }
       ref.read(multiplayerArenaControllerProvider(widget.duelId).notifier).broadcastSeed(seed, duration, mode);
       ticks++;
    });
  }

  void _generateOptionsForCurrentWord(String correctWord) {
    if (_fullDatabase == null) return;
    final words = _fullDatabase!.keys.toList();
    words.remove(correctWord);
    words.shuffle();
    _currentOptions = [correctWord, ...words.take(3)]..shuffle();
  }

  void _submitAnswer(String selectedOption, String correctWord) {
    if (_hasAnsweredCurrent || _secondsLeft <= 0) return;
    
    setState(() {
       _hasAnsweredCurrent = true;
    });
    
    final bool isCorrect = selectedOption == correctWord;
    HapticFeedback.heavyImpact();
    
    if (isCorrect) {
       final me = ref.read(currentUserProvider);
       final controller = ref.read(multiplayerArenaControllerProvider(widget.duelId).notifier);
       final state = ref.read(multiplayerArenaControllerProvider(widget.duelId));
       
       final currentScore = state.scores[me?.id ?? ''] ?? 0;
       
       controller.sendScoreAction(currentScore + 1, 'Found the right word', selectedOption);
    }
    
    // Auto move to next question
    Future.delayed(const Duration(seconds: 2), () {
       if (mounted) {
           setState(() {
              _currentQuestionIndex++;
              _hasAnsweredCurrent = false;
              _currentOptions = [];
           });
       }
    });
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = ref.watch(themeControllerProvider);
    final isDark = baseTheme.isDarkMode;
    
    final surfaceColor = isDark ? baseTheme.surfaceColor : const Color(0xFF0F172A);
    final textColor = isDark ? baseTheme.textColor : Colors.white;
    const neonAccent = Color(0xFF00FFCC); // Cyan neon
    const goldAccent = Color(0xFFFFB75E); // Gold

    final arenaState = ref.watch(multiplayerArenaControllerProvider(widget.duelId));
    final lobbyState = ref.watch(lobbyControllerProvider);
    final duel = lobbyState.valueOrNull;

    ref.listen(multiplayerArenaControllerProvider(widget.duelId), (prev, next) {
       if ((prev == null || prev.seed.isEmpty) && next.seed.isNotEmpty) {
          if (mounted) setState(() { _secondsLeft = next.duration; });
          _startGameTimer();
       }
    });

    return Scaffold(
      body: MeshBackground(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8), // Extremely dark for combat focus
          ),
          child: SafeArea(
            child: Column(
              children: [
                // 1. TOP: Global Battle Timer
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.redAccent),
                        onPressed: () {
                          // Surrender
                          HapticFeedback.lightImpact();
                          ref.read(lobbyControllerProvider.notifier).leaveDuel(widget.duelId);
                          Navigator.of(context).pop();
                        },
                      ),
                      ScaleTransition(
                         scale: _pulseAnimation,
                         child: Container(
                           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                           decoration: BoxDecoration(
                             color: Colors.redAccent.withValues(alpha: 0.1),
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                           ),
                           child: Text(
                             "${_secondsLeft}s",
                             style: GoogleFonts.outfit(
                               color: Colors.redAccent,
                               fontWeight: FontWeight.bold,
                               fontSize: 24,
                               letterSpacing: 2,
                             ),
                           ),
                         ),
                      ),
                      const SizedBox(width: 48), // Padding alignment
                    ],
                  ),
                ),

                // 2. CENTER: Combat Area (The Json Gameplay injection)
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: _buildGameplayArea(arenaState, surfaceColor, textColor, neonAccent),
                  )
                ),

                // 3. Battle Log overlay
                SizedBox(
                  height: 60,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.0, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstOut,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: arenaState.battleLog.length,
                      itemBuilder: (context, index) {
                         final log = arenaState.battleLog[index];
                         String name = 'User_${log.userId.substring(0, 4)}';
                         if (duel != null) {
                            final match = duel.participants.where((p) => p.userId == log.userId).firstOrNull;
                            if (match != null && match.profiles != null && match.profiles!.username.isNotEmpty) {
                               name = match.profiles!.username;
                            }
                         }
                         return Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
                           child: Text(
                              "$name found '${log.word}' !",
                              style: TextStyle(
                                 color: neonAccent,
                                 fontSize: 13,
                                 fontWeight: FontWeight.w600,
                                 fontStyle: FontStyle.italic,
                                 shadows: const [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1))]
                              ),
                           ),
                         );
                      },
                    ),
                  ),
                ),

                // 4. BOTTOM: Realtime LiveLeaderboard
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: surfaceColor.withValues(alpha: 0.9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      border: Border(top: BorderSide(color: neonAccent.withValues(alpha: 0.3))),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            "LIVE SCORE",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                               color: neonAccent,
                               letterSpacing: 4,
                               fontWeight: FontWeight.bold,
                               fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildLeaderboardList(duel, arenaState.scores, neonAccent),
                        ),
                      ],
                    ),
                  )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameplayArea(ArenaState state, Color surfaceColor, Color textColor, Color neonAccent) {
     if (!_isDbLoaded) {
        return const Center(child: CircularProgressIndicator());
     }
     if (state.seed.isEmpty) {
        return Center(
           child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 const CircularProgressIndicator(color: Color(0xFFFFB75E)),
                 const SizedBox(height: 16),
                 Text("Receiving combat scenario...", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic))
              ],
           )
        );
     }
     
     if (_currentQuestionIndex >= state.seed.length) {
        return Center(
           child: Text("Waiting for endgame calculation...", style: TextStyle(color: neonAccent, fontWeight: FontWeight.bold))
        );
     }
     
     final targetWord = state.seed[_currentQuestionIndex];
     final node = _fullDatabase![targetWord];
     if (node == null) return const Center(child: Text("Error fetching question data"));

     if (_currentOptions.isEmpty) {
        _generateOptionsForCurrentWord(targetWord);
     }

     final isWordToDef = state.mode == 'word_to_def';
     final questionText = isWordToDef ? targetWord : (node['definition_en'] ?? "No definition found.");

     return PhysicalModel(
        color: surfaceColor,
        elevation: 8,
        borderRadius: BorderRadius.circular(24),
        child: Container(
           padding: const EdgeInsets.all(24),
           decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1))
           ),
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Text(
                   "QUESTION ${_currentQuestionIndex + 1} / ${state.seed.length}",
                   style: GoogleFonts.inter(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 2),
                 ),
                 const SizedBox(height: 16),
                 Expanded(
                    child: Center(
                       child: SingleChildScrollView(
                         child: Text(
                            isWordToDef ? questionText.toUpperCase() : questionText,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                               color: textColor,
                               fontSize: isWordToDef ? 36 : 22,
                               fontWeight: FontWeight.w600,
                            ),
                         ),
                       ),
                    )
                 ),
                 const SizedBox(height: 24),
                 ..._currentOptions.map((option) {
                    final isCorrect = option == targetWord;
                    final showFeedback = _hasAnsweredCurrent;
                    
                    String buttonText = option;
                    if (isWordToDef) {
                        buttonText = _fullDatabase![option]?['definition_en'] ?? option;
                    }
                    
                    Color btnColor = surfaceColor;
                    Color btnText = textColor;
                    
                    if (showFeedback) {
                       if (isCorrect) {
                          btnColor = Colors.green.withValues(alpha: 0.5);
                          btnText = Colors.greenAccent;
                       } else {
                          btnColor = Colors.red.withValues(alpha: 0.3);
                          btnText = Colors.redAccent;
                       }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () => _submitAnswer(option, targetWord),
                        child: AnimatedContainer(
                           duration: const Duration(milliseconds: 300),
                           padding: const EdgeInsets.symmetric(vertical: 16),
                           decoration: BoxDecoration(
                              color: btnColor,
                              border: Border.all(color: showFeedback && isCorrect ? Colors.green : Colors.white.withValues(alpha: 0.2)),
                              borderRadius: BorderRadius.circular(16)
                           ),
                           child: Center(
                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 12.0),
                               child: Text(
                                 isWordToDef ? buttonText : buttonText.toUpperCase(),
                                 textAlign: TextAlign.center,
                                 maxLines: isWordToDef ? 3 : 1,
                                 overflow: TextOverflow.ellipsis,
                                 style: GoogleFonts.inter(
                                    color: btnText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isWordToDef ? 13 : 16,
                                    letterSpacing: isWordToDef ? 0 : 2,
                                 ),
                               ),
                             ),
                           ),
                        ),
                      ),
                    );
                 })
              ],
           ),
        ),
     );
  }

  Widget _buildLeaderboardList(dynamic duel, Map<String, int> scoresMap, Color neonAccent) {
     if (duel == null) return const SizedBox();

     final participants = List.from(duel.participants);
     participants.sort((a, b) {
        final scoreA = scoresMap[a.userId] ?? 0;
        final scoreB = scoresMap[b.userId] ?? 0;
        return scoreB.compareTo(scoreA); // Max first
     });

     final maxScoreEncountered = participants.isNotEmpty ? (scoresMap[participants.first.userId] ?? 0) : 0;
     final maxScoreCeiling = max(maxScoreEncountered, 10); 

     final me = ref.watch(currentUserProvider);

     return ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
           final p = participants[index];
           final score = scoresMap[p.userId] ?? 0;
           
           String name = 'User_${p.userId.substring(0, 5)}';
           if (p.profiles != null && p.profiles.username.isNotEmpty) {
              name = p.profiles.username;
           } else if (p.profiles != null && p.profiles.firstName != null) {
              name = p.profiles.firstName!;
           }

           final isMe = p.userId == me?.id;
           final barPercentage = (score / maxScoreCeiling).clamp(0.0, 1.0);

           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 8.0),
             child: Row(
               children: [
                 SizedBox(
                   width: 70,
                   child: Text(
                     isMe ? "YOU" : name,
                     style: TextStyle(
                        color: isMe ? neonAccent : Colors.white70,
                        fontWeight: isMe ? FontWeight.bold : FontWeight.w500,
                        fontSize: 12
                     ),
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
                 const SizedBox(width: 8),
                 Expanded(
                   child: LayoutBuilder(
                     builder: (context, constraints) {
                        return Stack(
                          children: [
                            Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCirc,
                              width: max(constraints.maxWidth * barPercentage, 10.0), // minimum width to be visible
                              height: 10,
                              decoration: BoxDecoration(
                                color: isMe ? neonAccent : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                   if (isMe) BoxShadow(color: neonAccent.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 0)
                                ],
                              ),
                            ),
                          ]
                        );
                     }
                   ),
                 ),
                 const SizedBox(width: 12),
                 SizedBox(
                   width: 20,
                   child: Text(
                     score.toString(),
                     textAlign: TextAlign.right,
                     style: TextStyle(
                        color: isMe ? neonAccent : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                     ),
                   ),
                 )
               ],
             ),
           );
        },
     );
  }
}
