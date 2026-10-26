import 'package:flutter/material.dart';
import '../../services/devotional_service.dart';
import '../../widgets/devotional_card.dart';
import '../../widgets/section_header.dart';

class FestivalsScreen extends StatelessWidget {
  final DevotionalService devotionalService;

  const FestivalsScreen({
    super.key,
    required this.devotionalService,
  });

  @override
  Widget build(BuildContext context) {
    final festivals = devotionalService.getFestivals();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Festivals & Vrats',
            subtitle: 'Upcoming Hindu festivals, tithis and rituals',
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: festivals.length,
              itemBuilder: (context, index) {
                return DevotionalCard(item: festivals[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
