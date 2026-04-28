import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/exam_goal_provider.dart';
import 'package:wisdom_gre_app/core/components/settings_dialog.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/presentation/screens/flashcard_screen.dart';
import 'package:wisdom_gre_app/features/podcast/presentation/screens/podcast_screen.dart';
import 'package:wisdom_gre_app/features/arena/presentation/screens/arena_screen.dart';
import 'package:wisdom_gre_app/features/multiplayer/presentation/multiplayer_lobby_screen.dart';
import 'package:wisdom_gre_app/features/multiplayer/presentation/matchmaking_hub_screen.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:wisdom_gre_app/features/dashboard/presentation/profile_stats_screen.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/subscription_provider.dart';
import 'package:wisdom_gre_app/features/subscriptions/presentation/paywall_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vocabularyAsync = ref.watch(vocabularyProvider);
    final themeData = ref.watch(themeControllerProvider);
    final examDate = ref.watch(examDateProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final isPremium = ref.watch(subscriptionStatusProvider).value ?? false;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: MeshBackground(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isPremium)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                        foregroundColor: const Color(0xFFD4AF37),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      icon: const Icon(Icons.workspace_premium, size: 20),
                      label: const Text('Upgrade', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const PaywallScreen()),
                        );
                      },
                    ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.bar_chart_rounded, color: themeData.textColor, size: 28),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProfileStatsScreen()),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.settings, color: themeData.textColor, size: 28),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const SettingsDialog(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              profileAsync.when(
                data: (profile) => Text(
                  'Welcome Back, ${profile?.firstName ?? profile?.username ?? 'Scholar'}!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: themeData.textColor,
                    letterSpacing: -0.5,
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text(
                  'Welcome Back!', 
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: themeData.textColor,
                  ),
                ),
              ),
              Text(
                'Ready to conquer the GRE?',
                style: TextStyle(
                  fontSize: 18,
                  color: themeData.textColor.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 36),
              vocabularyAsync.when(
                data: (words) {
                  final dailyGoalValue = ref.watch(dailyGoalProvider(totalWords: words.length));
                  
                    return Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: themeData.surfaceColor,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: themeData.isDarkMode ? themeData.textColor.withValues(alpha: 0.1) : Colors.transparent,
                          width: 1.5,
                        ),
                        boxShadow: [
                          if (!themeData.isDarkMode)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          else
                            BoxShadow(
                              color: themeData.textColor.withValues(alpha: 0.08),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                        ],
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Words',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeData.textColor.withValues(alpha: 0.7),
                              ),
                            ),
                            Text(
                              '${words.length}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: themeData.textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Divider(color: themeData.textColor.withValues(alpha: 0.2)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Exam Date',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeData.textColor.withValues(alpha: 0.7),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                final selected = await showDatePicker(
                                  context: context,
                                  initialDate: examDate ?? DateTime.now().add(const Duration(days: 30)),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                                );
                                if (selected != null) {
                                  ref.read(examDateProvider.notifier).setDate(selected);
                                }
                              },
                              icon: Icon(Icons.calendar_today, color: themeData.textColor),
                              label: Text(
                                examDate != null ? DateFormat('MMM d, yyyy').format(examDate) : 'Set Date',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themeData.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (examDate != null) ...[
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  themeData.textColor.withValues(alpha: 0.08),
                                  themeData.textColor.withValues(alpha: 0.02),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: themeData.textColor.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.flag, color: themeData.textColor),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    'Your goal: $dailyGoalValue words / day',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: themeData.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeData.textColor,
                              foregroundColor: themeData.surfaceColor,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 8,
                              shadowColor: themeData.textColor.withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const FlashcardScreen()),
                              );
                            },
                            child: const Text(
                              'Start Learning',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: themeData.isDarkMode ? Colors.white : const Color(0xFF111827),
                              side: BorderSide(
                                color: themeData.isDarkMode 
                                  ? Colors.white.withValues(alpha: 0.3) 
                                  : const Color(0xFF111827).withValues(alpha: 0.3), 
                                width: 2
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: themeData.isDarkMode 
                                ? themeData.surfaceColor.withValues(alpha: 0.5) 
                                : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              if (!isPremium) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const PaywallScreen()),
                                );
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const PodcastScreen()),
                              );
                            },
                            icon: Icon(!isPremium ? Icons.lock : Icons.headphones_rounded, color: themeData.isDarkMode ? Colors.white : const Color(0xFF111827)),
                            label: Text(
                              !isPremium ? 'Listen to Podcast (Premium)' : 'Listen to Podcast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: themeData.isDarkMode ? Colors.white : const Color(0xFF111827),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: themeData.isDarkMode ? Colors.amber[400] : Colors.amber[800],
                              side: BorderSide(color: (themeData.isDarkMode ? Colors.amber[400]! : Colors.amber[800]!).withValues(alpha: 0.5), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: (themeData.isDarkMode ? Colors.amber[800]! : Colors.amber[600]!).withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (!isPremium) {
                                // Strict server-side check to prevent bypass due to stream lag
                                try {
                                  final user = ref.read(currentUserProvider);
                                  if (user != null) {
                                    final data = await Supabase.instance.client
                                        .from('profiles')
                                        .select('daily_duels_count, last_duel_date')
                                        .eq('id', user.id)
                                        .single();
                                    
                                    final count = data['daily_duels_count'] as int? ?? 0;
                                    final lastDateStr = data['last_duel_date'] as String?;
                                    
                                    if (lastDateStr != null) {
                                      final lastDate = DateTime.parse(lastDateStr).toLocal();
                                      final now = DateTime.now();
                                      if (lastDate.year == now.year && lastDate.month == now.month && lastDate.day == now.day) {
                                        if (count >= 1) {
                                          if (context.mounted) _showArenaLimitDialog(context, themeData);
                                          return;
                                        }
                                      }
                                    }
                                  }
                                } catch (_) {
                                  // Fallback to local state if offline or error
                                  final profile = ref.read(userProfileProvider).valueOrNull;
                                  if (profile != null && profile.lastDuelDate != null) {
                                    final lastDate = profile.lastDuelDate!.toLocal();
                                    final now = DateTime.now();
                                    if (lastDate.year == now.year && lastDate.month == now.month && lastDate.day == now.day) {
                                      if (profile.dailyDuelsCount >= 1) {
                                        if (context.mounted) _showArenaLimitDialog(context, themeData);
                                        return;
                                      }
                                    }
                                  }
                                }
                              }

                              final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
                              if (connectivityResult.contains(ConnectivityResult.none)) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Offline: Network connection required'), backgroundColor: Colors.orange)
                                  );
                                }
                                return;
                              }
                              if (context.mounted) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const ArenaScreen()),
                                );
                              }
                            },
                            icon: Icon(!isPremium ? Icons.lock : Icons.sports_esports),
                            label: Text(
                              !isPremium ? 'Enter The Arena (1/day)' : 'Enter The Arena',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: themeData.isDarkMode ? const Color(0xFF00FFCC) : const Color(0xFF007A66),
                              side: BorderSide(color: (themeData.isDarkMode ? const Color(0xFF00FFCC) : const Color(0xFF007A66)).withValues(alpha: 0.5), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: (themeData.isDarkMode ? const Color(0xFF00FFCC) : const Color(0xFF007A66)).withValues(alpha: 0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (!isPremium) {
                                // Strict server-side check to prevent bypass due to stream lag
                                try {
                                  final user = ref.read(currentUserProvider);
                                  if (user != null) {
                                    final data = await Supabase.instance.client
                                        .from('profiles')
                                        .select('daily_duels_count, last_duel_date')
                                        .eq('id', user.id)
                                        .single();
                                    
                                    final count = data['daily_duels_count'] as int? ?? 0;
                                    final lastDateStr = data['last_duel_date'] as String?;
                                    
                                    if (lastDateStr != null) {
                                      final lastDate = DateTime.parse(lastDateStr).toLocal();
                                      final now = DateTime.now();
                                      if (lastDate.year == now.year && lastDate.month == now.month && lastDate.day == now.day) {
                                        if (count >= 1) {
                                          if (context.mounted) _showArenaLimitDialog(context, themeData);
                                          return;
                                        }
                                      }
                                    }
                                  }
                                } catch (_) {
                                  // Fallback to local state if offline or error
                                  final profile = ref.read(userProfileProvider).valueOrNull;
                                  if (profile != null && profile.lastDuelDate != null) {
                                    final lastDate = profile.lastDuelDate!.toLocal();
                                    final now = DateTime.now();
                                    if (lastDate.year == now.year && lastDate.month == now.month && lastDate.day == now.day) {
                                      if (profile.dailyDuelsCount >= 1) {
                                        if (context.mounted) _showArenaLimitDialog(context, themeData);
                                        return;
                                      }
                                    }
                                  }
                                }
                              }

                              final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
                              if (connectivityResult.contains(ConnectivityResult.none)) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Offline: Network connection required'), backgroundColor: Colors.orange)
                                  );
                                }
                                return;
                              }
                              if (context.mounted) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const MatchmakingHubScreen()),
                                );
                              }
                            },
                            icon: Icon(!isPremium ? Icons.lock : Icons.hub),
                            label: Text(
                              !isPremium ? 'Multiplayer Lobby (1/day)' : 'Multiplayer Lobby',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(color: themeData.textColor),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'Error loading vocabulary',
                    style: TextStyle(color: themeData.textColor),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showArenaLimitDialog(BuildContext context, AppThemeData theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.surfaceColor,
          title: Row(
            children: [
              const Icon(Icons.workspace_premium, color: Colors.amber, size: 32),
              const SizedBox(width: 8),
              Text('Daily Limit Reached', style: TextStyle(color: theme.textColor)),
            ],
          ),
          content: Text(
            "You have exhausted your daily free Arena ticket. Upgrade to Platinium for unlimited battles!",
            style: TextStyle(color: theme.textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: theme.textColor.withOpacity(0.7))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaywallScreen()));
              },
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }
}
