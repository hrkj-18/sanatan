import 'package:flutter/material.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class BhaktiScreen extends StatefulWidget {
  final DevotionalService devotionalService;

  const BhaktiScreen({
    super.key,
    required this.devotionalService,
  });

  @override
  State<BhaktiScreen> createState() => _BhaktiScreenState();
}

class _BhaktiScreenState extends State<BhaktiScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Aarti',
    'Mantra',
    'Chalisa',
    'Stotram',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final allItems = widget.devotionalService.getBhaktiItems();

    final filteredItems = _selectedCategory == 'All'
        ? allItems
        : allItems.where((i) => i.category == _selectedCategory).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Bhakti Sangrah',
            subtitle: 'Sacred Aartis, Mantras, Chalisas and Stotrams',
          ),
          const SizedBox(height: 12),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                    selectedColor: colorScheme.primaryContainer,
                    checkmarkColor: colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
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
                      'No content available in this category.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return DevotionalCard(item: filteredItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
