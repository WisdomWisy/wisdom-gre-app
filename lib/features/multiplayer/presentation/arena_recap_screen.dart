import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/multiplayer/domain/lobby_controller.dart';
import 'package:wisdom_gre_app/features/multiplayer/data/models/duel_participant.dart';
import 'package:wisdom_gre_app/features/dashboard/presentation/screens/dashboard_screen.dart';

class ArenaRecapScreen extends ConsumerWidget {
  final Map<String, int> finalScores;
  final List<DuelParticipant> participants;

  const ArenaRecapScreen({super.key, required this.finalScores, required this.participants});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseTheme = ref.watch(themeControllerProvider);
    final isDark = baseTheme.isDarkMode;
    
    final surfaceColor = isDark ? baseTheme.surfaceColor : const Color(0xFF0F172A);
    final textColor = isDark ? baseTheme.textColor : Colors.white;
    const neonAccent = Color(0xFF00FFCC); 
    const goldAccent = Color(0xFFFFB75E); 

    // Extract sorted leaderboard entries
    final sortedScores = finalScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    String winnerId = sortedScores.isNotEmpty ? sortedScores.first.key : "Unknown";
    int highestScore = sortedScores.isNotEmpty ? sortedScores.first.value : 0;

    return Scaffold(
      body: MeshBackground(
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6)),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                   flex: 2,
                   child: Center(
                      child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                            const Icon(Icons.emoji_events, size: 80, color: goldAccent),
                            const SizedBox(height: 16),
                            Text(
                              "MATCH OVER",
                              style: GoogleFonts.outfit(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: goldAccent,
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Highest Score: $highestScore",
                              style: GoogleFonts.inter(color: Colors.white70),
                            ),
                         ],
                      ),
                   )
                ),
                
                Expanded(
                   flex: 3,
                   child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                         color: surfaceColor.withValues(alpha: 0.8),
                         borderRadius: BorderRadius.circular(24),
                         border: Border.all(color: neonAccent.withValues(alpha: 0.3)),
                      ),
                      child: ListView.separated(
                         padding: const EdgeInsets.all(24),
                         itemCount: sortedScores.length,
                         separatorBuilder: (context, index) => const Divider(color: Colors.white24),
                         itemBuilder: (context, index) {
                            final entry = sortedScores[index];
                            final isWinner = index == 0;
                            
                            final match = participants.where((p) => p.userId == entry.key).firstOrNull;
                            String displayName = 'User_${entry.key.substring(0, 5)}';
                            if (match != null && match.profiles != null) {
                               if (match.profiles!.username.trim().isNotEmpty) {
                                  displayName = match.profiles!.username.trim();
                               } else if (match.profiles!.firstName != null && match.profiles!.firstName!.trim().isNotEmpty) {
                                  displayName = match.profiles!.firstName!.trim();
                               }
                            }
                            
                            return ListTile(
                               leading: CircleAvatar(
                                  backgroundColor: isWinner ? goldAccent.withValues(alpha: 0.2) : Colors.white12,
                                  child: Text(
                                     "#${index + 1}",
                                     style: TextStyle(color: isWinner ? goldAccent : Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                               ),
                               title: Text(displayName, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                               trailing: Text(
                                  "${entry.value} pts", 
                                  style: TextStyle(color: neonAccent, fontSize: 18, fontWeight: FontWeight.bold)
                               ),
                            );
                         },
                      ),
                   )
                ),

                Padding(
                   padding: const EdgeInsets.all(32.0),
                   child: ElevatedButton(
                     onPressed: () {
                        HapticFeedback.heavyImpact();
                        ref.read(lobbyControllerProvider.notifier).resetLobby();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const DashboardScreen()),
                          (Route<dynamic> route) => false,
                        );
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: goldAccent,
                       minimumSize: const Size.fromHeight(60),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                       elevation: 10,
                       shadowColor: goldAccent.withValues(alpha: 0.5),
                     ),
                     child: Text(
                       'CLAIM REWARDS & EXIT',
                       style: GoogleFonts.outfit(
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                         letterSpacing: 2,
                       ),
                     ),
                   ),
                )
              ],
            ),
          )
        )
      )
    );
  }
}
