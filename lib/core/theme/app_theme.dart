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
      // Platinium Light Palette (for all ThemeTypes in light mode)
      return [
        const Color(0xFFF3F4F6), // Gris ultra-léger
        const Color(0xFFE5E7EB),
        const Color(0xFFF9FAFB),
        const Color(0xFFD1D5DB),
      ];
    }
  }

  Color get textColor => isDarkMode ? Colors.white : const Color(0xFF111827);
  Color get surfaceColor => isDarkMode ? Colors.black.withOpacity(0.5) : const Color(0xFFFFFFFF);
  Color get scaffoldBackgroundColor => isDarkMode ? const Color(0xFF121212) : const Color(0xFFF3F4F6);
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
