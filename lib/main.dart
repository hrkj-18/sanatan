import 'package:flutter/material.dart';
import 'config/app_config.dart';
import 'navigation/main_navigation_screen.dart';
import 'services/devotional_service.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SanatanSathiyaApp());
}

class SanatanSathiyaApp extends StatefulWidget {
  const SanatanSathiyaApp({super.key});

  @override
  State<SanatanSathiyaApp> createState() => _SanatanSathiyaAppState();
}

class _SanatanSathiyaAppState extends State<SanatanSathiyaApp> {
  late final ThemeService _themeService;
  late final DevotionalService _devotionalService;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService();
    _devotionalService = DevotionalService();
  }

  @override
  void dispose() {
    _themeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeService,
      builder: (context, child) {
        return MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeService.themeMode,
          home: MainNavigationScreen(
            themeService: _themeService,
            devotionalService: _devotionalService,
          ),
        );
      },
    );
  }
}
