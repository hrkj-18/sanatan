import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app_config.dart';
import 'l10n/app_localizations.dart';
import 'navigation/main_navigation_screen.dart';
import 'services/devotional_service.dart';
import 'services/locale_service.dart';
import 'services/panchang_service.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(SanatanSathiyaApp(prefs: prefs));
}

class SanatanSathiyaApp extends StatefulWidget {
  final SharedPreferences? prefs;
  final PanchangService? panchangService;

  const SanatanSathiyaApp({super.key, this.prefs, this.panchangService});

  @override
  State<SanatanSathiyaApp> createState() => _SanatanSathiyaAppState();
}

class _SanatanSathiyaAppState extends State<SanatanSathiyaApp> {
  late final ThemeService _themeService;
  late final LocaleService _localeService;
  late final DevotionalService _devotionalService;
  late final PanchangService _panchangService;
  bool _ownsPanchangService = false;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService(prefs: widget.prefs);
    _localeService = LocaleService(prefs: widget.prefs);
    _devotionalService = DevotionalService(prefs: widget.prefs);
    if (widget.panchangService != null) {
      _panchangService = widget.panchangService!;
      _ownsPanchangService = false;
    } else {
      _panchangService = MockPanchangService();
      _ownsPanchangService = true;
    }
  }

  @override
  void dispose() {
    _themeService.dispose();
    _localeService.dispose();
    _devotionalService.dispose();
    if (_ownsPanchangService) {
      _panchangService.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _themeService,
        _localeService,
        _devotionalService,
        _panchangService,
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
            panchangService: _panchangService,
          ),
        );
      },
    );
  }
}
