import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/core/providers/language_provider.dart';
import 'package:wisdom_gre_app/core/providers/tts_settings_provider.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/promo_code_service.dart';

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
      content: SingleChildScrollView(
        child: Column(
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
          
          // ── Profile ────────────────────────────────────────
          _SectionHeader('Account', theme),
          ListTile(
            dense: true,
            leading: Icon(Icons.person_outline, color: theme.textColor),
            title: Text('Edit Profile', style: TextStyle(color: theme.textColor)),
            trailing: Icon(Icons.chevron_right, color: theme.textColor),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => const EditProfileDialog(),
              );
            },
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

          const Divider(height: 24),

          // ── Subscriptions & Promos ───────────────────────────
          _SectionHeader('Subscription', theme),
          const _PromoCodeSection(),

          const Divider(height: 24),

          // ── Account ──────────────────────────────────────────
          _SectionHeader('Account', theme),
          ListTile(
            dense: true,
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Disconnect', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            onTap: () {
              ref.read(authControllerProvider.notifier).signOut();
              Navigator.of(context).pop(); // Close dialog
            },
          ),
        ],
      ),
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

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({super.key});

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentProfile();
  }
  
  void _loadCurrentProfile() async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final res = await Supabase.instance.client.from('profiles').select().eq('id', user.id).maybeSingle();
      if (res != null) {
        _firstNameController.text = res['first_name'] ?? '';
        _lastNameController.text = res['last_name'] ?? '';
      }
    }
  }

  void _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user != null) {
        await Supabase.instance.client.from('profiles').update({
          'first_name': _firstNameController.text.trim(),
          'last_name': _lastNameController.text.trim(),
        }).eq('id', user.id);
        if (mounted) Navigator.pop(context);
        
        // Refresh the profile provider manually since the stream might not cache immediately 
        // depending on real-time setup of profiles, but since we use stream() on profiles it should auto-update.
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    
    return AlertDialog(
      backgroundColor: theme.surfaceColor,
      title: Text('Edit Profile', style: TextStyle(color: theme.textColor)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _firstNameController,
            style: TextStyle(color: theme.textColor),
            decoration: InputDecoration(labelText: 'First Name', labelStyle: TextStyle(color: theme.textColor.withValues(alpha: 0.6))),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lastNameController,
            style: TextStyle(color: theme.textColor),
            decoration: InputDecoration(labelText: 'Last Name', labelStyle: TextStyle(color: theme.textColor.withValues(alpha: 0.6))),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        _isLoading 
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save'),
            ),
      ],
    );
  }
}

class _PromoCodeSection extends ConsumerStatefulWidget {
  const _PromoCodeSection();

  @override
  ConsumerState<_PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends ConsumerState<_PromoCodeSection> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  void _redeem() async {
    final code = _controller.text;
    if (code.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(promoCodeServiceProvider.notifier).redeemCode(code);
      if (mounted) {
        _controller.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Promo code applied successfully! Premium unlocked.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: theme.textColor),
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: 'Have a promo code?',
                hintStyle: TextStyle(color: theme.textColor.withValues(alpha: 0.4)),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.textColor.withValues(alpha: 0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.textColor.withValues(alpha: 0.2)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : ElevatedButton(
                  onPressed: _redeem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFED8F03),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Redeem', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
        ],
      ),
    );
  }
}


