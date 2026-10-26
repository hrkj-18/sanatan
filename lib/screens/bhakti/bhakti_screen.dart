import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class BhaktiScreen extends StatefulWidget {
  final DevotionalService devotionalService;

  const BhaktiScreen({super.key, required this.devotionalService});

  @override
  State<BhaktiScreen> createState() => _BhaktiScreenState();
}

class _BhaktiScreenState extends State<BhaktiScreen> {
  String _selectedCategoryKey = 'All';

  String _getCategoryLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'Aarti':
        return l10n.categoryAarti;
      case 'Mantra':
        return l10n.categoryMantra;
      case 'Chalisa':
        return l10n.categoryChalisa;
      case 'Stotram':
        return l10n.categoryStotram;
      default:
        return l10n.categoryAll;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final allItems = widget.devotionalService.getBhaktiItems();

    final categories = ['All', 'Aarti', 'Mantra', 'Chalisa', 'Stotram'];

    final filteredItems = _selectedCategoryKey == 'All'
        ? allItems
        : allItems.where((i) => i.category == _selectedCategoryKey).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.bhaktiSangrah,
            subtitle: l10n.bhaktiSubtitle,
          ),
          const SizedBox(height: 12),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((catKey) {
                final isSelected = _selectedCategoryKey == catKey;
                final labelText = _getCategoryLabel(l10n, catKey);
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(labelText),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryKey = catKey;
                      });
                    },
                    selectedColor: colorScheme.primaryContainer,
                    checkmarkColor: colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Items List
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      l10n.noContentInCategory,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return DevotionalCard(
                        item: item,
                        onBookmarkToggle: () =>
                            widget.devotionalService.toggleBookmark(item.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
