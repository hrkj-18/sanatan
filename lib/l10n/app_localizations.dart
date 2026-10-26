import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Sanatan Sathiya'**
  String get appName;

  /// The tagline of the application
  ///
  /// In en, this message translates to:
  /// **'Your Daily Hindu Devotional Companion'**
  String get appTagline;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navBhakti.
  ///
  /// In en, this message translates to:
  /// **'Bhakti'**
  String get navBhakti;

  /// No description provided for @navFestivals.
  ///
  /// In en, this message translates to:
  /// **'Festivals'**
  String get navFestivals;

  /// No description provided for @navSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get navSaved;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @greetingSubhoPrabhat.
  ///
  /// In en, this message translates to:
  /// **'Subho Prabhat'**
  String get greetingSubhoPrabhat;

  /// No description provided for @aajKaPanchang.
  ///
  /// In en, this message translates to:
  /// **'Aaj Ka Panchang'**
  String get aajKaPanchang;

  /// No description provided for @tithi.
  ///
  /// In en, this message translates to:
  /// **'Tithi'**
  String get tithi;

  /// No description provided for @nakshatra.
  ///
  /// In en, this message translates to:
  /// **'Nakshatra'**
  String get nakshatra;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunset;

  /// No description provided for @verseOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Verse of the Day'**
  String get verseOfTheDay;

  /// No description provided for @verseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily spiritual guidance from sacred scriptures'**
  String get verseSubtitle;

  /// No description provided for @dailySadhana.
  ///
  /// In en, this message translates to:
  /// **'Daily Sadhana'**
  String get dailySadhana;

  /// No description provided for @dailySadhanaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recommended daily prayers & chanting'**
  String get dailySadhanaSubtitle;

  /// No description provided for @morningAarti.
  ///
  /// In en, this message translates to:
  /// **'Morning Aarti'**
  String get morningAarti;

  /// No description provided for @mantraJaap.
  ///
  /// In en, this message translates to:
  /// **'Mantra Jaap'**
  String get mantraJaap;

  /// No description provided for @bhaktiSangrah.
  ///
  /// In en, this message translates to:
  /// **'Bhakti Sangrah'**
  String get bhaktiSangrah;

  /// No description provided for @bhaktiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sacred Aartis, Mantras, Chalisas and Stotrams'**
  String get bhaktiSubtitle;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryAarti.
  ///
  /// In en, this message translates to:
  /// **'Aarti'**
  String get categoryAarti;

  /// No description provided for @categoryMantra.
  ///
  /// In en, this message translates to:
  /// **'Mantra'**
  String get categoryMantra;

  /// No description provided for @categoryChalisa.
  ///
  /// In en, this message translates to:
  /// **'Chalisa'**
  String get categoryChalisa;

  /// No description provided for @categoryStotram.
  ///
  /// In en, this message translates to:
  /// **'Stotram'**
  String get categoryStotram;

  /// No description provided for @noContentInCategory.
  ///
  /// In en, this message translates to:
  /// **'No content available in this category.'**
  String get noContentInCategory;

  /// No description provided for @festivalsAndVrats.
  ///
  /// In en, this message translates to:
  /// **'Festivals & Vrats'**
  String get festivalsAndVrats;

  /// No description provided for @festivalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Hindu festivals, tithis and rituals'**
  String get festivalsSubtitle;

  /// No description provided for @savedPrayers.
  ///
  /// In en, this message translates to:
  /// **'Saved Prayers'**
  String get savedPrayers;

  /// No description provided for @savedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your bookmarked verses, aartis and mantras'**
  String get savedSubtitle;

  /// No description provided for @noSavedItems.
  ///
  /// In en, this message translates to:
  /// **'No saved items yet'**
  String get noSavedItems;

  /// No description provided for @noSavedItemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark icon on any prayer or verse to save it here.'**
  String get noSavedItemsSubtitle;

  /// No description provided for @moreAndSettings.
  ///
  /// In en, this message translates to:
  /// **'More & Settings'**
  String get moreAndSettings;

  /// No description provided for @moreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your devotional experience'**
  String get moreSubtitle;

  /// No description provided for @appearanceTheme.
  ///
  /// In en, this message translates to:
  /// **'Appearance Theme'**
  String get appearanceTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @devotionalLanguage.
  ///
  /// In en, this message translates to:
  /// **'Devotional Language'**
  String get devotionalLanguage;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी (Hindi)'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'मराठी (Marathi)'**
  String get marathi;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text Size'**
  String get textSize;

  /// No description provided for @textSizeMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get textSizeMedium;

  /// App version label
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersionLabel(String version);

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get toggleTheme;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
