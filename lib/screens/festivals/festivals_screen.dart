import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class FestivalsScreen extends StatelessWidget {
  final DevotionalService devotionalService;

  const FestivalsScreen({super.key, required this.devotionalService});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final festivals = devotionalService.getFestivals();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: l10n.festivalsAndVrats,
            subtitle: l10n.festivalsSubtitle,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: festivals.length,
              itemBuilder: (context, index) {
                final festival = festivals[index];
                return DevotionalCard(
                  item: festival,
                  onBookmarkToggle: () =>
                      devotionalService.toggleBookmark(festival.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
