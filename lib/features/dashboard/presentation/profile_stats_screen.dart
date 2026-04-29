import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/stats_controller.dart';
import 'dart:ui';
import 'dart:math';

class ProfileStatsScreen extends ConsumerStatefulWidget {
  const ProfileStatsScreen({super.key});

  @override
  ConsumerState<ProfileStatsScreen> createState() => _ProfileStatsScreenState();
}

class _ProfileStatsScreenState extends ConsumerState<ProfileStatsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _flameController;

  @override
  void initState() {
    super.initState();
    _flameController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _flameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    final isDark = theme.isDarkMode;
    
    final surfaceColor = isDark ? theme.surfaceColor : const Color(0xFF1E293B);
    final textColor = isDark ? theme.textColor : Colors.white;
    const emeraldColor = Color(0xFF10B981); // Neon/Emerald Green
    const redColor = Color(0xFFEF4444); // Muted Red
    const greyColor = Color(0xFF475569); // Dark Grey

    final user = ref.watch(currentUserProvider);
    final profileQuery = ref.watch(userProfileProvider);
    final profile = profileQuery.valueOrNull;

    final statsQuery = ref.watch(statsControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "QUANTIFIED SELF",
          style: GoogleFonts.outfit(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: MeshBackground(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6), // Dark overlay for glassmorphism
          ),
          child: SafeArea(
            child: statsQuery.when(
              data: (stats) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 1: Player Identity
                      _buildIdentitySection(profile, surfaceColor, textColor),
                      const SizedBox(height: 32),
                      
                      // Section 2: Arena Record
                      _buildArenaRecordSection(stats, surfaceColor, textColor, emeraldColor, redColor, greyColor),
                      const SizedBox(height: 32),

                      // Section 3: Vocabulary Mastery
                      _buildVocabularySection(stats, surfaceColor, textColor),
                      const SizedBox(height: 32),

                      // Section 4: Difficulty Breakdown
                      _buildDifficultySection(stats, surfaceColor, textColor),
                      const SizedBox(height: 32),

                      // Section 5: Daily Streak
                      _buildStreakSection(stats, surfaceColor, textColor),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text("Error loading stats", style: TextStyle(color: textColor))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child, required Color surfaceColor}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: surfaceColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildIdentitySection(dynamic profile, Color surfaceColor, Color textColor) {
    final name = profile?.firstName ?? profile?.username ?? "Agent";
    final lastName = profile?.lastName ?? "";
    final avatar = profile?.avatarUrl;

    return _buildGlassContainer(
      surfaceColor: surfaceColor,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            backgroundImage: avatar != null ? NetworkImage(avatar) : null,
            child: avatar == null
                ? Icon(Icons.person, size: 40, color: textColor.withValues(alpha: 0.5))
                : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name $lastName".trim(),
                  style: GoogleFonts.outfit(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "GRE Challenger",
                  style: GoogleFonts.inter(
                    color: textColor.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: textColor.withValues(alpha: 0.7)),
            onPressed: () {
              // TODO: Navigate to Edit Profile
            },
          )
        ],
      ),
    );
  }

  Widget _buildArenaRecordSection(ProfileStatsState stats, Color surfaceColor, Color textColor, Color emerald, Color red, Color grey) {
    final wins = stats.arenaWins;
    final losses = stats.arenaLosses;
    final hasData = wins > 0 || losses > 0;
    
    return _buildGlassContainer(
      surfaceColor: surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ARENA RECORD",
            style: GoogleFonts.outfit(
              color: textColor.withValues(alpha: 0.7),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 40,
                      sections: hasData 
                        ? [
                            if (wins > 0)
                              PieChartSectionData(
                                color: emerald,
                                value: wins.toDouble(),
                                title: '$wins',
                                radius: 30,
                                titleStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            if (losses > 0)
                              PieChartSectionData(
                                color: red,
                                value: losses.toDouble(),
                                title: '$losses',
                                radius: 25,
                                titleStyle: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                          ]
                        : [
                            PieChartSectionData(
                                color: grey,
                                value: 1,
                                title: 'No Data',
                                radius: 25,
                                titleStyle: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                          ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegend("Victories", emerald, wins),
                  const SizedBox(height: 12),
                  _buildLegend("Defeats", red, losses),
                  const SizedBox(height: 16),
                  if (hasData)
                    Text(
                      "Win Rate: ${((wins / (wins + losses)) * 100).toStringAsFixed(1)}%",
                      style: GoogleFonts.inter(
                        color: textColor.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color, int value) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildVocabularySection(ProfileStatsState stats, Color surfaceColor, Color textColor) {
    final mastered = stats.masteredWords;
    final learning = stats.learningWords;
    final toReview = stats.toReviewWords;
    final total = max(stats.totalWords, 1); // Avoid div by 0

    return _buildGlassContainer(
      surfaceColor: surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "VOCABULARY MASTERY",
            style: GoogleFonts.outfit(
              color: textColor.withValues(alpha: 0.7),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 20,
              child: Row(
                children: [
                  if (mastered > 0)
                    Expanded(
                      flex: mastered,
                      child: Container(color: Colors.greenAccent),
                    ),
                  if (learning > 0)
                    Expanded(
                      flex: learning,
                      child: Container(color: Colors.orangeAccent),
                    ),
                  if (toReview > 0)
                    Expanded(
                      flex: toReview,
                      child: Container(color: Colors.grey.shade700),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildVocabStat("Mastered", mastered, Colors.greenAccent),
              _buildVocabStat("Learning", learning, Colors.orangeAccent),
              _buildVocabStat("To Review", toReview, Colors.grey.shade400),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVocabStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: GoogleFonts.outfit(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultySection(ProfileStatsState stats, Color surfaceColor, Color textColor) {
    return _buildGlassContainer(
      surfaceColor: surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DIFFICULTY BREAKDOWN",
            style: GoogleFonts.outfit(
              color: textColor.withValues(alpha: 0.7),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          _buildDiffRow("Easy", stats.seenEasy, stats.totalEasy, Colors.greenAccent),
          const SizedBox(height: 12),
          _buildDiffRow("Medium", stats.seenMedium, stats.totalMedium, Colors.orangeAccent),
          const SizedBox(height: 12),
          _buildDiffRow("Hard", stats.seenHard, stats.totalHard, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildDiffRow(String label, int seen, int total, Color color) {
    final double progress = total > 0 ? seen / total : 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
            Text("$seen / $total", style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakSection(ProfileStatsState stats, Color surfaceColor, Color textColor) {
    return _buildGlassContainer(
      surfaceColor: surfaceColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DAILY STREAK",
                style: GoogleFonts.outfit(
                  color: textColor.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    stats.currentStreak.toString(),
                    style: GoogleFonts.outfit(
                      color: textColor,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Days",
                    style: GoogleFonts.inter(
                      color: textColor.withValues(alpha: 0.6),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ScaleTransition(
            scale: Tween(begin: 0.9, end: 1.1).animate(_flameController),
            child: Icon(
              Icons.local_fire_department,
              color: Colors.orangeAccent,
              size: 64,
              shadows: [
                Shadow(color: Colors.deepOrangeAccent.withValues(alpha: 0.6), blurRadius: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
