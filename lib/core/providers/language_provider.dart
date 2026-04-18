import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_provider.g.dart';

/// The secondary/translation language the user studies in.
/// English = no translation shown (synonyms + mnemonic only).
enum AppLanguage {
  fr,
  es,
  en,
}

@Riverpod(keepAlive: true)
class LanguageController extends _$LanguageController {
  static const _key = 'appLanguage';

  @override
  AppLanguage build() {
    // Optimistically load persisted value; default to English while loading.
    _loadFromPrefs();
    return AppLanguage.en;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key);
    if (index != null && index < AppLanguage.values.length) {
      state = AppLanguage.values[index];
    }
  }

  Future<void> setLanguage(AppLanguage lang) async {
    state = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, lang.index);
  }
}
