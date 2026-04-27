import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';

import 'package:wisdom_gre_app/features/multiplayer/domain/lobby_controller.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:wisdom_gre_app/features/multiplayer/presentation/arena_multiplayer_screen.dart';
import 'package:wisdom_gre_app/features/dashboard/presentation/profile_stats_screen.dart';

class MultiplayerLobbyScreen extends ConsumerStatefulWidget {
  const MultiplayerLobbyScreen({super.key});

  @override
  ConsumerState<MultiplayerLobbyScreen> createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends ConsumerState<MultiplayerLobbyScreen> with SingleTickerProviderStateMixin {
  bool _isJoining = false;
  final _joinCodeController = TextEditingController();
  int _selectedDuration = 60;
  String _selectedMode = 'def_to_word';

  void _createDuel() {
    HapticFeedback.heavyImpact();
    ref.read(lobbyControllerProvider.notifier).createDuel();
    setState(() {
      _isJoining = false;
    });
  }

  void _toggleJoin() {
    HapticFeedback.lightImpact();
    setState(() {
      _isJoining = true;
    });
  }

  void _submitJoin() {
    final code = _joinCodeController.text;
    if (code.isNotEmpty) {
      ref.read(lobbyControllerProvider.notifier).joinDuel(code);
    }
  }

  @override
  void dispose() {
    final lobbyNotifier = ref.read(lobbyControllerProvider.notifier);
    _joinCodeController.dispose();
    super.dispose();
    
    Future.microtask(() {
      try { lobbyNotifier.resetLobby(); } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // Forcing a darker competitive theme override for this specific screen
    final baseTheme = ref.watch(themeControllerProvider);
    final isDark = baseTheme.isDarkMode;
    
    // Using deep navy/black tones to make the neon stand out
    final surfaceColor = isDark ? baseTheme.surfaceColor : const Color(0xFF0F172A);
    final textColor = isDark ? baseTheme.textColor : Colors.white;
    const neonAccent = Color(0xFF00FFCC); // Cyan neon
    const goldAccent = Color(0xFFFFB75E); // Gold

    final lobbyState = ref.watch(lobbyControllerProvider);
    final duel = lobbyState.valueOrNull;
    final onlineUsers = ref.watch(onlineUsersProvider);

    ref.listen(lobbyControllerProvider, (previous, next) {
      if (next.hasError) {
        if (next.error.toString().contains('FREEMIUM_BLOCK')) {
           _showPremiumPaywall(baseTheme);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('STATE ERROR: ${next.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 10),
            ),
          );
        }
      } else {
        final nextDuel = next.valueOrNull;
        if (nextDuel?.status == 'playing' && nextDuel != null) {
          // Transition to Arena
          if (context.mounted) {
             final me = ref.read(currentUserProvider);
             final isHost = nextDuel.hostId == me?.id;
             Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (_) => ArenaMultiplayerScreen(
                 duelId: nextDuel.id,
                 hostSelectedDuration: isHost ? _selectedDuration : null,
                 hostSelectedMode: isHost ? _selectedMode : null,
               ))
             );
          }
        }
      }
    });

    final me = ref.watch(currentUserProvider);
    final isHost = duel?.hostId == me?.id;
    final isLobbyFull = duel != null && duel.participants.length >= duel.maxPlayers;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'MULTIPLAYER ARENA',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            color: neonAccent,
            tooltip: 'Quantified Self',
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileStatsScreen()),
              );
            },
          ),
          if (duel != null)
            IconButton(
              icon: Icon(isHost ? Icons.delete_forever : Icons.exit_to_app, color: Colors.redAccent),
              tooltip: isHost ? 'Destroy Session' : 'Leave Session',
              onPressed: () {
                HapticFeedback.mediumImpact();
                _confirmAction(context, isHost ? 'Destroy Room' : 'Leave Room',
                  isHost ? 'Are you sure you want to permanently destroy this session for everyone?' : 'Are you sure you want to abandon this session and leave?', () async {
                  await ref.read(lobbyControllerProvider.notifier).leaveDuel(duel.id);
                  if (context.mounted) Navigator.of(context).pop();
                });
              },
            ),
        ],
      ),
      body: MeshBackground(
        // Override mesh to feel darker and more intense
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                
                // Main Interactive Area
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (duel != null) ...[
                          _buildCodeDisplay(duel.roomCode, surfaceColor, textColor, goldAccent),
                          const SizedBox(height: 32),
                        ],

                        // Player Lounge
                        Text(
                          duel != null ? 'PLAYERS IN LOBBY (${duel.participants.length}/${duel.maxPlayers})' : 'PLAYERS IN LOBBY',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: textColor.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: (duel == null) 
                            ? Center(child: Text('Create or Join a Duel', style: TextStyle(color: textColor.withValues(alpha: 0.5))))
                            : ListView.builder(
                                itemCount: duel.participants.length,
                                itemBuilder: (context, index) {
                                  final participant = duel.participants[index];
                                  final profile = participant.profiles;
                                  final isParticipantHost = participant.userId == duel.hostId;
                                  final isMe = participant.userId == me?.id;
                                  
                                  String finalName = 'User_${participant.userId.substring(0, 5)}';
                                  if (profile != null) {
                                    if (profile.username.trim().isNotEmpty) {
                                      finalName = profile.username.trim();
                                    } else if (profile.firstName != null && profile.firstName!.trim().isNotEmpty) {
                                      finalName = profile.firstName!.trim();
                                    }
                                  }
                                  
                                  String displayName = isMe ? 'You ($finalName)' : finalName;
                                  
                                  return _buildPlayerCard(
                                    displayName,
                                    participant.userId,
                                    isParticipantHost,
                                    isMe,
                                    onlineUsers.contains(participant.userId),
                                    isHost,
                                    surfaceColor,
                                    textColor,
                                    goldAccent,
                                    neonAccent,
                                    duel.id,
                                  );
                                },
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                
                // Timer Selection for Host
                if (isHost && duel!.participants.length > 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                          "BATTLE DURATION",
                          style: GoogleFonts.inter(
                            color: goldAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 12
                          ),
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<int>(
                          segments: const [
                            ButtonSegment(value: 30, label: Text('30s SPRINT')),
                            ButtonSegment(value: 60, label: Text('60s STANDARD')),
                            ButtonSegment(value: 90, label: Text('90s MARATHON')),
                          ],
                          selected: {_selectedDuration},
                          onSelectionChanged: (Set<int> newSelection) {
                            setState(() {
                              _selectedDuration = newSelection.first;
                            });
                          },
                          style: SegmentedButton.styleFrom(
                            backgroundColor: surfaceColor.withValues(alpha: 0.5),
                            selectedForegroundColor: neonAccent,
                            selectedBackgroundColor: neonAccent.withValues(alpha: 0.1),
                            side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "GAME MODE",
                          style: GoogleFonts.inter(
                            color: goldAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 12
                          ),
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: 'def_to_word', label: Text('Find Word')),
                            ButtonSegment(value: 'word_to_def', label: Text('Find Def')),
                          ],
                          selected: {_selectedMode},
                          onSelectionChanged: (Set<String> newSelection) {
                            setState(() {
                              _selectedMode = newSelection.first;
                            });
                          },
                          style: SegmentedButton.styleFrom(
                            backgroundColor: surfaceColor.withValues(alpha: 0.5),
                            selectedForegroundColor: neonAccent,
                            selectedBackgroundColor: neonAccent.withValues(alpha: 0.1),
                            side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Bottom Ready Button
                if (isHost && duel!.participants.length > 1)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                      child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.vibrate();
                          ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Broadcasting Start Battle Signal...'), duration: Duration(seconds: 1))
                          );
                          ref.read(lobbyControllerProvider.notifier).startBattle(duel.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: const Size.fromHeight(60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 10,
                          shadowColor: Colors.redAccent.withValues(alpha: 0.5),
                        ),
                        child: Text(
                          'START BATTLE',
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                else if (duel != null && !isHost)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Text('Waiting for host to start...', style: TextStyle(color: neonAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? color : Colors.white.withValues(alpha: 0.1),
            width: isActive ? 2 : 1,
          ),
          boxShadow: isActive
              ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 15, spreadRadius: 1)]
              : [],
        ),
        child: Column(
          children: [
            Icon(icon, color: isActive ? color : Colors.white54, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                color: isActive ? color : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeDisplay(String code, Color surfaceColor, Color textColor, Color goldAccent) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceColor.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: goldAccent.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(color: goldAccent.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Text(
            'SHARE THIS CODE',
            style: GoogleFonts.inter(
              color: goldAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            code,
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: 8,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinField(Color surfaceColor, Color textColor, Color neonAccent) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceColor.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: neonAccent.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(color: neonAccent.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Text(
            'ENTER DUEL CODE',
            style: GoogleFonts.inter(
              color: neonAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _joinCodeController,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.characters,
            style: GoogleFonts.outfit(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              letterSpacing: 8,
              color: textColor,
            ),
            decoration: InputDecoration(
              hintText: 'GRE-XXX',
              hintStyle: GoogleFonts.outfit(
                color: textColor.withValues(alpha: 0.2),
                letterSpacing: 8,
              ),
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _submitJoin(),
            onChanged: (val) {
              if (val.length > 7) {
                _joinCodeController.text = val.substring(0, 7);
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitJoin,
            style: ElevatedButton.styleFrom(
              backgroundColor: neonAccent,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('CONNECT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildPlayerCard(
    String name,
    String userId,
    bool isParticipantHost,
    bool isMe,
    bool isOnline,
    bool currentUserIsHost,
    Color surfaceColor,
    Color textColor,
    Color goldAccent,
    Color neonAccent,
    String? duelId,
  ) {
    final bgAlpha = isOnline ? (isMe ? 0.1 : 0.6) : (isMe ? 0.05 : 0.2);
    final borderColor = isMe ? neonAccent.withValues(alpha: isOnline ? 0.5 : 0.1) : Colors.white.withValues(alpha: isOnline ? 0.05 : 0.01);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isMe ? neonAccent.withValues(alpha: bgAlpha) : surfaceColor.withValues(alpha: bgAlpha),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Opacity(
                opacity: isOnline ? 1.0 : 0.4,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isParticipantHost ? goldAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isParticipantHost ? Icons.workspace_premium : Icons.person_outline,
                    color: isParticipantHost ? goldAccent : Colors.white54,
                    size: 20,
                  ),
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.greenAccent : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: surfaceColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Opacity(
              opacity: isOnline ? 1.0 : 0.4,
              child: Text(
                name,
                style: GoogleFonts.inter(
                  color: isParticipantHost || isMe ? textColor : textColor.withValues(alpha: 0.5),
                  fontWeight: isParticipantHost || isMe ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  decoration: isOnline ? null : TextDecoration.lineThrough,
                  decorationColor: textColor.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          if (isMe) ...[
            Opacity(
              opacity: isOnline ? 1.0 : 0.4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: neonAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'YOU',
                  style: GoogleFonts.inter(
                    color: neonAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (isParticipantHost)
            Opacity(
              opacity: isOnline ? 1.0 : 0.4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: goldAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'HOST',
                  style: GoogleFonts.inter(
                    color: goldAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          if (currentUserIsHost && !isParticipantHost && duelId != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.person_remove_rounded),
              color: Colors.redAccent.withValues(alpha: 0.7),
              tooltip: 'Kick Player',
              onPressed: () {
                HapticFeedback.mediumImpact();
                _confirmAction(
                  context,
                  'Kick Player',
                  'Are you sure you want to kick $name from the lobby?',
                  () {
                    ref.read(lobbyControllerProvider.notifier).kickParticipant(duelId, userId);
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _confirmAction(BuildContext context, String title, String message, VoidCallback onConfirm) async {
    final themeData = ref.read(themeControllerProvider);
    final surfaceColor = themeData.isDarkMode ? themeData.surfaceColor : Colors.white;
    final textColor = themeData.isDarkMode ? themeData.textColor : Colors.black;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: surfaceColor.withValues(alpha: 0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        content: Text(message, style: TextStyle(color: textColor.withValues(alpha: 0.8))),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (result == true) {
      onConfirm();
    }
  }

  void _showPremiumPaywall(AppThemeData theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.surfaceColor,
          title: Row(
            children: [
              const Icon(Icons.workspace_premium, color: Colors.amber, size: 32),
              const SizedBox(width: 8),
              Text('Premium Required', style: TextStyle(color: theme.textColor)),
            ],
          ),
          content: Text(
            "You've reached your daily free limit for the Arena (1 duel/day). Unlock everything to conquer the GRE!",
            style: TextStyle(color: theme.textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Maybe Later', style: TextStyle(color: theme.textColor.withOpacity(0.7))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                // Future Paywall UI
              },
              child: const Text('View Premium Plans'),
            ),
          ],
        );
      },
    );
  }
}
