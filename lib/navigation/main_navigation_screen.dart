import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../screens/bhakti/bhakti_screen.dart';
import '../screens/festivals/festivals_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/saved/saved_screen.dart';
import '../screens/today/today_screen.dart';
import '../services/devotional_service.dart';
import '../services/locale_service.dart';
import '../services/panchang_service.dart';
import '../services/theme_service.dart';

class MainNavigationScreen extends StatefulWidget {
  final ThemeService themeService;
  final LocaleService localeService;
  final DevotionalService devotionalService;
  final PanchangService panchangService;

  const MainNavigationScreen({
    super.key,
    required this.themeService,
    required this.localeService,
    required this.devotionalService,
    required this.panchangService,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      TodayScreen(
        devotionalService: widget.devotionalService,
        panchangService: widget.panchangService,
      ),
      BhaktiScreen(devotionalService: widget.devotionalService),
      FestivalsScreen(devotionalService: widget.devotionalService),
      SavedScreen(devotionalService: widget.devotionalService),
      MoreScreen(
        themeService: widget.themeService,
        localeService: widget.localeService,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeService.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode_outlined,
            ),
            tooltip: l10n.toggleTheme,
            onPressed: () => widget.themeService.toggleTheme(),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.wb_sunny_outlined),
            selectedIcon: const Icon(Icons.wb_sunny),
            label: l10n.navToday,
          ),
          NavigationDestination(
            icon: const Icon(Icons.auto_awesome_outlined),
            selectedIcon: const Icon(Icons.auto_awesome),
            label: l10n.navBhakti,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event_note_outlined),
            selectedIcon: const Icon(Icons.event_note),
            label: l10n.navFestivals,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bookmark_outline),
            selectedIcon: const Icon(Icons.bookmark),
            label: l10n.navSaved,
          ),
          NavigationDestination(
            icon: const Icon(Icons.grid_view_outlined),
            selectedIcon: const Icon(Icons.grid_view),
            label: l10n.navMore,
          ),
        ],
      ),
    );
  }
}
