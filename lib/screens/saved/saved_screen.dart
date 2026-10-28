import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class SavedScreen extends StatelessWidget {
  final DevotionalService devotionalService;

  const SavedScreen({super.key, required this.devotionalService});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final savedItems = devotionalService.getSavedItems();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: l10n.savedPrayers, subtitle: l10n.savedSubtitle),
          const SizedBox(height: 12),
          Expanded(
            child: savedItems.isEmpty
                ? Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_outline,
                            size: 48,
                            color: colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.noSavedItems,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.noSavedItemsSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: savedItems.length,
                    itemBuilder: (context, index) {
                      final item = savedItems[index];
                      return DevotionalCard(
                        item: item,
                        onBookmarkToggle: () =>
                            devotionalService.toggleBookmark(item.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
