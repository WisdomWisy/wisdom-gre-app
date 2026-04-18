import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/core/providers/language_provider.dart';
import 'package:wisdom_gre_app/core/providers/tts_settings_provider.dart';

/// Application-wide settings dialog.
///
/// Covers:
///   - Dark mode toggle
///   - Premium theme toggle
///   - Translation / secondary language selector
///   - Podcast TTS speech rate slider
class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);
    final language = ref.watch(languageControllerProvider);
    final speechRate = ref.watch(ttsSpeechRateControllerProvider);

    return AlertDialog(
      backgroundColor: theme.surfaceColor.withValues(alpha: 0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Settings', style: TextStyle(color: theme.textColor, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Appearance ─────────────────────────────────────
          _SectionHeader('Appearance', theme),
          _SwitchTile(
            icon: theme.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            label: 'Dark Mode',
            value: theme.isDarkMode,
            theme: theme,
            onChanged: (_) => ref.read(themeControllerProvider.notifier).toggleDarkMode(),
          ),
          _SwitchTile(
            icon: Icons.palette_outlined,
            label: 'Premium Theme',
            value: theme.type == ThemeType.purpleGold,
            theme: theme,
            onChanged: (_) => ref.read(themeControllerProvider.notifier).toggleThemeType(),
          ),

          const Divider(height: 24),

          // ── Language ────────────────────────────────────────
          _SectionHeader('Podcast Language', theme),
          ListTile(
            dense: true,
            leading: Icon(Icons.translate_rounded, color: theme.textColor),
            title: Text('Translation Target', style: TextStyle(color: theme.textColor)),
            trailing: DropdownButton<AppLanguage>(
              value: language,
              dropdownColor: theme.surfaceColor,
              underline: const SizedBox.shrink(),
              style: TextStyle(color: theme.textColor, fontWeight: FontWeight.w600),
              items: const [
                DropdownMenuItem(value: AppLanguage.en, child: Text('English')),
                DropdownMenuItem(value: AppLanguage.fr, child: Text('Français')),
                DropdownMenuItem(value: AppLanguage.es, child: Text('Español')),
              ],
              onChanged: (lang) {
                if (lang != null) {
                  ref.read(languageControllerProvider.notifier).setLanguage(lang);
                }
              },
            ),
          ),

          const Divider(height: 24),

          // ── Podcast ─────────────────────────────────────────
          _SectionHeader('Podcast', theme),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed_rounded, color: theme.textColor, size: 20),
                    const SizedBox(width: 12),
                    Text('Speech Rate', style: TextStyle(color: theme.textColor)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: theme.textColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${speechRate.toStringAsFixed(1)}×',
                    style: TextStyle(color: theme.textColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Slider(
            value: speechRate,
            min: 0.1,
            max: 1.0,
            divisions: 9,
            activeColor: theme.textColor,
            inactiveColor: theme.textColor.withValues(alpha: 0.2),
            onChanged: (val) =>
                ref.read(ttsSpeechRateControllerProvider.notifier).setRate(val),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close', style: TextStyle(color: theme.textColor, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

// ── Private helper widgets ──────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label, this.theme);
  final String label;
  final AppThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 4),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: theme.textColor.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.theme,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final AppThemeData theme;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: theme.textColor),
      title: Text(label, style: TextStyle(color: theme.textColor)),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}
