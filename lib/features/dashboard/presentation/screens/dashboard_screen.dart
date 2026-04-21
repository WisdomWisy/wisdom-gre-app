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

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vocabularyAsync = ref.watch(vocabularyProvider);
    final themeData = ref.watch(themeControllerProvider);
    final examDate = ref.watch(examDateProvider);
    final profileAsync = ref.watch(userProfileProvider);

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
                      color: themeData.surfaceColor.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: themeData.textColor.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                      boxShadow: [
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
                                Text(
                                  'Your goal: $dailyGoalValue words / day',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: themeData.textColor,
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
                              foregroundColor: themeData.textColor,
                              side: BorderSide(color: themeData.textColor.withValues(alpha: 0.3), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: themeData.surfaceColor.withValues(alpha: 0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const PodcastScreen()),
                              );
                            },
                            icon: Icon(Icons.headphones_rounded, color: themeData.textColor),
                            label: const Text(
                              'Listen to Podcast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.amber[400],
                              side: BorderSide(color: Colors.amber[400]!.withValues(alpha: 0.5), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: Colors.amber[800]!.withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
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
                            icon: const Icon(Icons.sports_esports),
                            label: const Text(
                              'Enter The Arena',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF00FFCC),
                              side: BorderSide(color: const Color(0xFF00FFCC).withValues(alpha: 0.5), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: const Color(0xFF00FFCC).withValues(alpha: 0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
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
                            icon: const Icon(Icons.hub),
                            label: const Text(
                              'Multiplayer Lobby',
                              style: TextStyle(
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
}
