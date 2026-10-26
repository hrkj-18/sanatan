import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/locale_service.dart';

class LanguageSelectorWidget extends StatelessWidget {
  final LocaleService localeService;

  const LanguageSelectorWidget({super.key, required this.localeService});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLanguageCode = localeService.languageCode;

    return SegmentedButton<String>(
      segments: [
        ButtonSegment<String>(
          value: 'system',
          icon: const Icon(Icons.settings_suggest_outlined),
          label: Text(l10n.systemDefault),
        ),
        const ButtonSegment<String>(value: 'en', label: Text('English')),
        const ButtonSegment<String>(value: 'hi', label: Text('हिन्दी')),
        const ButtonSegment<String>(value: 'mr', label: Text('मराठी')),
      ],
      selected: {currentLanguageCode ?? 'system'},
      onSelectionChanged: (Set<String> newSelection) {
        final code = newSelection.first;
        if (code == 'system') {
          localeService.setLocale(null);
        } else {
          localeService.setLocale(Locale(code));
        }
      },
    );
  }
}
