import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeControllerProvider);

    return Container(
      decoration: BoxDecoration(
        color: themeData.surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              themeData.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: themeData.textColor,
            ),
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toggleDarkMode();
            },
            tooltip: 'Toggle Dark Mode',
          ),
          Container(
            height: 24,
            width: 1,
            color: themeData.textColor.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          IconButton(
            icon: Icon(
              Icons.palette,
              color: themeData.type == ThemeType.purpleGold
                  ? Colors.purpleAccent
                  : Colors.grey,
            ),
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toggleThemeType();
            },
            tooltip: 'Toggle Premium Theme',
          ),
        ],
      ),
    );
  }
}
