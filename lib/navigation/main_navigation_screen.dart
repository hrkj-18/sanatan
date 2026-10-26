import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../screens/bhakti/bhakti_screen.dart';
import '../screens/festivals/festivals_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/saved/saved_screen.dart';
import '../screens/today/today_screen.dart';
import '../services/devotional_service.dart';
import '../services/theme_service.dart';

class MainNavigationScreen extends StatefulWidget {
  final ThemeService themeService;
  final DevotionalService devotionalService;

  const MainNavigationScreen({
    super.key,
    required this.themeService,
    required this.devotionalService,
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
      TodayScreen(devotionalService: widget.devotionalService),
      BhaktiScreen(devotionalService: widget.devotionalService),
      FestivalsScreen(devotionalService: widget.devotionalService),
      SavedScreen(devotionalService: widget.devotionalService),
      MoreScreen(themeService: widget.themeService),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConfig.appName),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeService.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode_outlined,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () => widget.themeService.toggleTheme(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.wb_sunny),
            label: AppConfig.navToday,
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: AppConfig.navBhakti,
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: AppConfig.navFestivals,
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: AppConfig.navSaved,
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: AppConfig.navMore,
          ),
        ],
      ),
    );
  }
}
