import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../services/theme_service.dart';
import '../../widgets/section_header.dart';
import '../../widgets/theme_toggle_widget.dart';

class MoreScreen extends StatelessWidget {
  final ThemeService themeService;

  const MoreScreen({
    super.key,
    required this.themeService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'More & Settings',
            subtitle: 'Customize your devotional experience',
          ),
          const SizedBox(height: 16),

          // Theme Settings Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.palette_outlined, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      Text(
                        'Appearance Theme',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: ThemeToggleWidget(themeService: themeService),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Devotional Settings Card
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language, color: colorScheme.primary),
                  title: const Text('Devotional Language'),
                  subtitle: const Text('Hindi & English'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading:
                      Icon(Icons.format_size, color: colorScheme.primary),
                  title: const Text('Text Size'),
                  subtitle: const Text('Medium'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // About Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      size: 32,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppConfig.appName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppConfig.appTagline,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Version ${AppConfig.appVersion}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
