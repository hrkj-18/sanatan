enum DevotionalCategory { verse, aarti, mantra, chalisa, stotram, festival }

class DevotionalItem {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String? category;
  final String? deity;
  final bool isSaved;
  final String? date;

  const DevotionalItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    this.category,
    this.deity,
    this.isSaved = false,
    this.date,
  });

  DevotionalItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    String? category,
    String? deity,
    bool? isSaved,
    String? date,
  }) {
    return DevotionalItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      category: category ?? this.category,
      deity: deity ?? this.deity,
      isSaved: isSaved ?? this.isSaved,
      date: date ?? this.date,
    );
  }
}
