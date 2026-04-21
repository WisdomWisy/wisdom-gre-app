import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:wisdom_gre_app/features/multiplayer/domain/lobby_controller.dart';
import 'package:wisdom_gre_app/features/multiplayer/presentation/multiplayer_lobby_screen.dart';

class MatchmakingHubScreen extends ConsumerStatefulWidget {
  const MatchmakingHubScreen({super.key});

  @override
  ConsumerState<MatchmakingHubScreen> createState() => _MatchmakingHubScreenState();
}

class _MatchmakingHubScreenState extends ConsumerState<MatchmakingHubScreen> {
  final TextEditingController _joinCodeController = TextEditingController();
  bool _isJoining = false;

  @override
  void dispose() {
    _joinCodeController.dispose();
    super.dispose();
  }

  void _createDuel() async {
    HapticFeedback.heavyImpact();
    // Use the provider to call create and then auto-push
    await ref.read(lobbyControllerProvider.notifier).createDuel();
    final duel = ref.read(lobbyControllerProvider).valueOrNull;
    if (duel != null && mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MultiplayerLobbyScreen()));
    }
  }

  void _joinDuel() async {
    HapticFeedback.heavyImpact();
    final code = _joinCodeController.text.trim();
    if (code.isEmpty) return;
    
    await ref.read(lobbyControllerProvider.notifier).joinDuel(code);
    final duel = ref.read(lobbyControllerProvider).valueOrNull;
    if (duel != null && mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MultiplayerLobbyScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeControllerProvider);
    final isDark = themeData.isDarkMode;
    final surfaceColor = isDark ? themeData.surfaceColor : Colors.white.withValues(alpha: 0.9);
    final textColor = isDark ? themeData.textColor : Colors.black;
    const neonAccent = Color(0xFF00FFCC); 
    const goldAccent = Color(0xFFFFB75E); 

    final lobbiesAsync = ref.watch(userLobbiesProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'MATCHMAKING HUB',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: MeshBackground(
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  
                  // CREATE OR JOIN
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          title: 'CREATE ROOM',
                          icon: Icons.add_rounded,
                          color: goldAccent,
                          onPressed: _createDuel,
                          isActive: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionButton(
                          title: 'JOIN ROOM',
                          icon: Icons.login_rounded,
                          color: neonAccent,
                          onPressed: () => setState(() => _isJoining = !_isJoining),
                          isActive: _isJoining,
                        ),
                      ),
                    ],
                  ),

                  if (_isJoining) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _joinCodeController,
                            style: TextStyle(color: neonAccent, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 2),
                            decoration: InputDecoration(
                              hintText: 'ROOM CODE',
                              hintStyle: TextStyle(color: neonAccent.withValues(alpha: 0.3)),
                              filled: true,
                              fillColor: surfaceColor,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: _joinDuel,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(color: neonAccent, borderRadius: BorderRadius.circular(16)),
                            child: const Icon(Icons.arrow_forward_rounded, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ],

                  const SizedBox(height: 48),
                  
                  // LIST OF ACTIVE LOBBIES
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MY ACTIVE ARENAS',
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: textColor.withValues(alpha: 0.6)),
                      ),
                      lobbiesAsync.maybeWhen(
                        data: (lobbies) => lobbies.length > 1 
                          ? TextButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                _confirmAction(context, 'Close All Sessions', 'Are you sure you want to completely clear away all your active game sessions?', () {
                                  final allIds = lobbies.map((l) => l.id).toList();
                                  ref.read(lobbyControllerProvider.notifier).leaveAllDuels(allIds);
                                });
                              },
                              child: Text('Close All', style: TextStyle(color: Colors.redAccent.withValues(alpha: 0.8), fontWeight: FontWeight.bold)),
                            )
                          : const SizedBox.shrink(),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  Expanded(
                    child: lobbiesAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error loading lobbies', style: TextStyle(color: textColor))),
                      data: (lobbies) {
                        if (lobbies.isEmpty) {
                          return Center(
                            child: Text('No active arenas.\nCreate or Join one to begin!', 
                            textAlign: TextAlign.center,
                            style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 16)),
                          );
                        }

                        return ListView.separated(
                          itemCount: lobbies.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final duel = lobbies[index];
                            final isHost = duel.hostId == currentUser?.id;
                            
                            return InkWell(
                              onTap: () {
                                ref.read(lobbyControllerProvider.notifier).connectToDuel(duel.id);
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const MultiplayerLobbyScreen()));
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: surfaceColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: isHost ? goldAccent.withValues(alpha: 0.5) : neonAccent.withValues(alpha: 0.5)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(isHost ? Icons.shield : Icons.sports_kabaddi, color: isHost ? goldAccent : neonAccent),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Code: ${duel.roomCode}', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: isHost ? goldAccent.withValues(alpha: 0.15) : neonAccent.withValues(alpha: 0.15),
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: isHost ? goldAccent : neonAccent, width: 1.5),
                                                ),
                                                child: Text(
                                                  isHost ? 'HOST' : 'CHALLENGER',
                                                  style: GoogleFonts.outfit(
                                                    color: isHost ? goldAccent : neonAccent,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text('${duel.participants.length}/${duel.maxPlayers} Players', style: TextStyle(color: textColor.withValues(alpha: 0.6))),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert, color: Colors.grey),
                                      color: surfaceColor,
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'leave',
                                          child: Text(isHost ? 'Destroy Room' : 'Leave Room', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                        ),
                                        if (lobbies.length > 1)
                                          const PopupMenuItem(
                                            value: 'leave_others',
                                            child: Text('Close ALL others', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                          ),
                                      ],
                                      onSelected: (value) async {
                                        HapticFeedback.mediumImpact();
                                        final controller = ref.read(lobbyControllerProvider.notifier);
                                        final allDuelIds = lobbies.map((l) => l.id).toList();
                                        
                                        if (value == 'leave') {
                                          _confirmAction(context, isHost ? 'Destroy Room' : 'Leave Room', 
                                            isHost ? 'Are you sure you want to permanently destory this session for everyone?' : 'Are you sure you want to abandon this session and leave?', () {
                                            controller.leaveDuel(duel.id);
                                          });
                                        } else if (value == 'leave_others') {
                                          _confirmAction(context, 'Close All Others', 'Are you sure you want to clear all other sessions?', () {
                                            controller.leaveAllOtherDuels(duel.id, allDuelIds);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? color.withValues(alpha: 0.5) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isActive ? color : Colors.white54, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isActive ? color : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
