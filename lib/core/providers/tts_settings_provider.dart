import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tts_settings_provider.g.dart';

/// Persists the user's preferred TTS speech rate across sessions.
/// Range: 0.1 (very slow) – 1.0 (native speed).
/// Default: 0.5 (comfortable for language learning).
@Riverpod(keepAlive: true)
class TtsSpeechRateController extends _$TtsSpeechRateController {
  static const _key = 'ttsSpeechRate';
  static const _defaultRate = 0.5;

  @override
  double build() {
    _loadFromPrefs();
    return _defaultRate;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getDouble(_key);
    if (saved != null) state = saved.clamp(0.1, 1.0);
  }

  Future<void> setRate(double rate) async {
    state = rate.clamp(0.1, 1.0);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key, state);
  }
}
