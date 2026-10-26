import 'package:flutter/material.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class SavedScreen extends StatelessWidget {
  final DevotionalService devotionalService;

  const SavedScreen({
    super.key,
    required this.devotionalService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final savedItems = devotionalService.getSavedItems();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Saved Prayers',
            subtitle: 'Your bookmarked verses, aartis and mantras',
          ),
          const SizedBox(height: 12),
          Expanded(
            child: savedItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_outline,
                          size: 48,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No saved items yet',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tap the bookmark icon on any prayer or verse to save it here.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: savedItems.length,
                    itemBuilder: (context, index) {
                      return DevotionalCard(item: savedItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
