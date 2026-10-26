import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app_config.dart';
import 'l10n/app_localizations.dart';
import 'navigation/main_navigation_screen.dart';
import 'services/devotional_service.dart';
import 'services/locale_service.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(SanatanSathiyaApp(prefs: prefs));
}

class SanatanSathiyaApp extends StatefulWidget {
  final SharedPreferences? prefs;

  const SanatanSathiyaApp({super.key, this.prefs});

  @override
  State<SanatanSathiyaApp> createState() => _SanatanSathiyaAppState();
}

class _SanatanSathiyaAppState extends State<SanatanSathiyaApp> {
  late final ThemeService _themeService;
  late final LocaleService _localeService;
  late final DevotionalService _devotionalService;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService(prefs: widget.prefs);
    _localeService = LocaleService(prefs: widget.prefs);
    _devotionalService = DevotionalService(prefs: widget.prefs);
  }

  @override
  void dispose() {
    _themeService.dispose();
    _localeService.dispose();
    _devotionalService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _themeService,
        _localeService,
        _devotionalService,
      ]),
      builder: (context, child) {
        return MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeService.themeMode,
          locale: _localeService.locale,
          supportedLocales: LocaleService.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            return LocaleService.resolveLocale(
              deviceLocale,
              _localeService.locale,
            );
          },
          home: MainNavigationScreen(
            themeService: _themeService,
            localeService: _localeService,
            devotionalService: _devotionalService,
          ),
        );
      },
    );
  }
}
