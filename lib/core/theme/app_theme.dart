import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme.g.dart';

enum ThemeType {
  purpleGold,
  darkSilver,
}

class AppThemeData {
  final ThemeType type;
  final bool isDarkMode;

  const AppThemeData({
    required this.type,
    required this.isDarkMode,
  });

  /// The first three colors are for the Mesh Gradient.
  List<Color> get gradientColors {
    if (isDarkMode) {
      if (type == ThemeType.purpleGold) {
        return [
          const Color(0xFF2C1052), // Deep Purple
          const Color(0xFF452B75), // Mid Purple
          const Color(0xFF1F1A2A), // Dark Background
          const Color(0xFFCC9933), // Dark Gold
        ];
      } else {
        return [
          const Color(0xFF1E1E1E), // Dark
          const Color(0xFF2D2D2D), // Darker Silver
          const Color(0xFF121212), // Almost black
          const Color(0xFF404040), // Silver edge
        ];
      }
    } else {
      if (type == ThemeType.purpleGold) {
        return [
          const Color(0xFF8A2BE2), // Purple
          const Color(0xFFE6E6FA), // Lavender
          const Color(0xFFFFD700), // Gold
          const Color(0xFFFFFFFF), // White
        ];
      } else {
        return [
          const Color(0xFFE0E0E0), // Light Silver
          const Color(0xFFF5F5F5), // White-ish
          const Color(0xFFBDBDBD), // Mid Silver
          const Color(0xFF9E9E9E), // Darker Silver
        ];
      }
    }
  }

  Color get textColor => isDarkMode ? Colors.white : Colors.black87;
  Color get surfaceColor => isDarkMode ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.7);
}

@riverpod
class ThemeController extends _$ThemeController {
  static const _themeTypeKey = 'themeType';
  static const _darkModeKey = 'darkMode';

  @override
  AppThemeData build() {
    _loadFromPrefs();
    // Default while loading
    return const AppThemeData(type: ThemeType.purpleGold, isDarkMode: true);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_darkModeKey) ?? true;
    final typeIndex = prefs.getInt(_themeTypeKey) ?? 0;
    
    state = AppThemeData(
      type: ThemeType.values[typeIndex],
      isDarkMode: isDark,
    );
  }

  Future<void> toggleDarkMode() async {
    final newState = AppThemeData(type: state.type, isDarkMode: !state.isDarkMode);
    state = newState;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, newState.isDarkMode);
  }

  Future<void> toggleThemeType() async {
    final newType = state.type == ThemeType.purpleGold ? ThemeType.darkSilver : ThemeType.purpleGold;
    final newState = AppThemeData(type: newType, isDarkMode: state.isDarkMode);
    state = newState;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeTypeKey, newType.index);
  }
}
