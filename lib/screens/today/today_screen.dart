import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/devotional_service.dart';
import '../../services/panchang_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class TodayScreen extends StatelessWidget {
  final DevotionalService devotionalService;
  final PanchangService panchangService;

  const TodayScreen({
    super.key,
    required this.devotionalService,
    required this.panchangService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final panchang = panchangService.getPanchangForDate(DateTime.now());
    final verseOfTheDay = devotionalService.getVerseOfTheDay();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.wb_sunny_rounded, color: colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.greetingSubhoPrabhat,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      l10n.appName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Panchang Summary Card
          Card(
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            l10n.aajKaPanchang,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          if (panchang.isMock)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: colorScheme.outline,
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                l10n.sampleData,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Chip(
                        label: Text(
                          panchang.samvat,
                          style: const TextStyle(fontSize: 11),
                        ),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: colorScheme.surface,
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = constraints.maxWidth > 300
                          ? (constraints.maxWidth - 12) / 2
                          : constraints.maxWidth;

                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: itemWidth,
                            child: _buildPanchangDetail(
                              context,
                              Icons.calendar_month,
                              l10n.tithi,
                              panchang.tithi,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: _buildPanchangDetail(
                              context,
                              Icons.star_outline,
                              l10n.nakshatra,
                              panchang.nakshatra,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: _buildPanchangDetail(
                              context,
                              Icons.wb_twilight,
                              l10n.sunrise,
                              panchang.sunrise,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: _buildPanchangDetail(
                              context,
                              Icons.nights_stay_outlined,
                              l10n.sunset,
                              panchang.sunset,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Verse of the Day
          SectionHeader(
            title: l10n.verseOfTheDay,
            subtitle: l10n.verseSubtitle,
          ),
          DevotionalCard(
            item: verseOfTheDay,
            onBookmarkToggle: () =>
                devotionalService.toggleBookmark(verseOfTheDay.id),
          ),

          const SizedBox(height: 24),

          // Daily Devotional Quick Actions
          SectionHeader(
            title: l10n.dailySadhana,
            subtitle: l10n.dailySadhanaSubtitle,
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth > 280
                  ? (constraints.maxWidth - 8) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: _buildActionChip(
                      context,
                      Icons.auto_awesome,
                      l10n.morningAarti,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _buildActionChip(
                      context,
                      Icons.self_improvement,
                      l10n.mantraJaap,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPanchangDetail(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: colorScheme.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionChip(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
