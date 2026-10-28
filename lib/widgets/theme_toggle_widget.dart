import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/theme_service.dart';

class ThemeToggleWidget extends StatelessWidget {
  final ThemeService themeService;

  const ThemeToggleWidget({super.key, required this.themeService});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<ThemeMode>(
        segments: [
          ButtonSegment<ThemeMode>(
            value: ThemeMode.system,
            icon: const Icon(Icons.brightness_auto),
            label: Text(l10n.themeSystem),
          ),
          ButtonSegment<ThemeMode>(
            value: ThemeMode.light,
            icon: const Icon(Icons.light_mode),
            label: Text(l10n.themeLight),
          ),
          ButtonSegment<ThemeMode>(
            value: ThemeMode.dark,
            icon: const Icon(Icons.dark_mode),
            label: Text(l10n.themeDark),
          ),
        ],
        selected: {themeService.themeMode},
        onSelectionChanged: (Set<ThemeMode> newSelection) {
          themeService.setThemeMode(newSelection.first);
        },
      ),
    );
  }
}
