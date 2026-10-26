import 'package:flutter/material.dart';
import '../services/theme_service.dart';

class ThemeToggleWidget extends StatelessWidget {
  final ThemeService themeService;

  const ThemeToggleWidget({
    super.key,
    required this.themeService,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment<ThemeMode>(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto),
          label: Text('System'),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode),
          label: Text('Light'),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode),
          label: Text('Dark'),
        ),
      ],
      selected: {themeService.themeMode},
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        themeService.setThemeMode(newSelection.first);
      },
    );
  }
}
