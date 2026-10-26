import 'package:flutter/material.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class TodayScreen extends StatelessWidget {
  final DevotionalService devotionalService;

  const TodayScreen({
    super.key,
    required this.devotionalService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final panchang = devotionalService.getTodayPanchang();
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
                child: Icon(
                  Icons.wb_sunny_rounded,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subho Prabhat',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'Sanatan Sathiya',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Panchang Summary Card
          Card(
            color: colorScheme.primaryContainer.withValues(alpha: 0.4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        panchang['day'] ?? 'Aaj Ka Panchang',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Chip(
                        label: Text(
                          panchang['samvat'] ?? '',
                          style: const TextStyle(fontSize: 11),
                        ),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: colorScheme.surface,
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPanchangDetail(
                        context,
                        Icons.calendar_month,
                        'Tithi',
                        panchang['tithi'] ?? '',
                      ),
                      _buildPanchangDetail(
                        context,
                        Icons.star_outline,
                        'Nakshatra',
                        panchang['nakshatra'] ?? '',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPanchangDetail(
                        context,
                        Icons.wb_twilight,
                        'Sunrise',
                        panchang['sunrise'] ?? '',
                      ),
                      _buildPanchangDetail(
                        context,
                        Icons.nights_stay_outlined,
                        'Sunset',
                        panchang['sunset'] ?? '',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Verse of the Day
          const SectionHeader(
            title: 'Verse of the Day',
            subtitle: 'Daily spiritual guidance from sacred scriptures',
          ),
          DevotionalCard(item: verseOfTheDay),

          const SizedBox(height: 24),

          // Daily Devotional Quick Actions
          const SectionHeader(
            title: 'Daily Sadhana',
            subtitle: 'Recommended daily prayers & chanting',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildActionChip(
                  context,
                  Icons.auto_awesome,
                  'Morning Aarti',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionChip(
                  context,
                  Icons.self_improvement,
                  'Mantra Jaap',
                ),
              ),
            ],
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionChip(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
