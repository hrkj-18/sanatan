import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/devotional_item.dart';

class DevotionalService extends ChangeNotifier {
  static const String prefKey = 'bookmarked_item_ids';

  final SharedPreferences? prefs;
  final Set<String> _bookmarkedIds = {};

  DevotionalService({this.prefs}) {
    _loadSavedBookmarks();
  }

  void _loadSavedBookmarks() {
    final p = prefs;
    if (p != null) {
      try {
        final savedList = p.getStringList(prefKey);
        if (savedList != null) {
          _bookmarkedIds.addAll(savedList.where((id) => id.isNotEmpty));
          return;
        }
      } catch (e) {
        debugPrint('Error reading saved bookmarks: $e');
      }
    }
    // Fresh install default: empty bookmark list
  }

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  Set<String> get bookmarkedIds => Set.unmodifiable(_bookmarkedIds);

  Future<void> toggleBookmark(String itemId) async {
    if (_bookmarkedIds.contains(itemId)) {
      _bookmarkedIds.remove(itemId);
    } else {
      _bookmarkedIds.add(itemId);
    }
    notifyListeners(); // Immediate UI update for instant responsiveness

    final p = prefs;
    if (p != null) {
      try {
        await p.setStringList(prefKey, _bookmarkedIds.toList());
      } catch (e) {
        debugPrint('Error saving bookmarks: $e');
      }
    }
  }

  DevotionalItem getVerseOfTheDay() {
    const raw = DevotionalItem(
      id: 'v_day_1',
      title: 'Bhagavad Gita 2.47',
      subtitle: 'Karma Yoga',
      content:
          'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।\nमा कर्मफलहेतुर्भूर्मा ते सङ्गोऽस्त्वकर्मणि॥\n\n'
          'You have a right to perform your prescribed duty, but you are not entitled to the fruits of action.',
      category: 'Verse',
      deity: 'Shri Krishna',
    );
    return raw.copyWith(isSaved: isBookmarked(raw.id));
  }

  List<DevotionalItem> getBhaktiItems() {
    final rawList = const [
      DevotionalItem(
        id: 'b_1',
        title: 'Hanuman Chalisa',
        subtitle: 'Forty Verses in Praise of Lord Hanuman',
        content: 'जय हनुमान ज्ञान गुण सागर। जय कपीश तिहुं लोक उजागर॥',
        category: 'Chalisa',
        deity: 'Hanuman',
      ),
      DevotionalItem(
        id: 'b_2',
        title: 'Shri Ram Amritwani',
        subtitle: 'Devotional Hymn for Lord Ram',
        content: 'राम नाम अम्रित है धारा, जो गावे सो उतरे पारा॥',
        category: 'Stotram',
        deity: 'Shri Ram',
      ),
      DevotionalItem(
        id: 'b_3',
        title: 'Gayatri Mantra',
        subtitle: 'Universal Prayer for Enlightenment',
        content: 'ॐ भूर्भुवः स्वः तत्सवितुर्वरेण्यं भर्गो देवस्य धीमहि धियो यो नः प्रचोदयात्॥',
        category: 'Mantra',
        deity: 'Gayatri Devi',
      ),
      DevotionalItem(
        id: 'b_4',
        title: 'Jai Ganesh Deva Aarti',
        subtitle: 'Aarti for Lord Ganesha',
        content:
            'जय गणेश जय गणेश जय गणेश देवा। माता जाकी पार्वती पिता महादेवा॥',
        category: 'Aarti',
        deity: 'Ganesha',
      ),
      DevotionalItem(
        id: 'b_5',
        title: 'Shiv Tandav Stotram',
        subtitle: 'Composition by Ravana in praise of Shiva',
        content: 'जटाटवीगलज्जलप्रवाहपावितस्थले गलेऽवलम्ब्य लम्बितां भुजङ्गतुङ्गमालिकाम्॥',
        category: 'Stotram',
        deity: 'Shiva',
      ),
    ];

    return rawList
        .map((item) => item.copyWith(isSaved: isBookmarked(item.id)))
        .toList();
  }

  List<DevotionalItem> getFestivals() {
    final rawList = const [
      DevotionalItem(
        id: 'f_1',
        title: 'Maha Shivratri',
        subtitle: 'The Great Night of Shiva',
        content: 'Celebrated in honor of Lord Shiva. Fasting and night-long vigil (Jagran) are observed by devotees.',
        category: 'Festival',
        date: 'Upcoming • Phalguna Krishna Chaturdashi',
      ),
      DevotionalItem(
        id: 'f_2',
        title: 'Holi',
        subtitle: 'Festival of Colors & Spring',
        content: 'Signifies the victory of good over evil with Holika Dahan followed by Rangwali Holi.',
        category: 'Festival',
        date: 'Upcoming • Phalguna Purnima',
      ),
      DevotionalItem(
        id: 'f_3',
        title: 'Ram Navami',
        subtitle: 'Birth of Lord Shri Ram',
        content: 'Marks the birth of Lord Ram in Ayodhya. Recitation of Ramayana and special pujas take place.',
        category: 'Festival',
        date: 'Upcoming • Chaitra Shukla Navami',
      ),
      DevotionalItem(
        id: 'f_4',
        title: 'Diwali',
        subtitle: 'Festival of Lights',
        content: 'Celebrates Lord Ram\'s return to Ayodhya and Lakshmi Puja for wisdom and prosperity.',
        category: 'Festival',
        date: 'Kartik Amavasya',
      ),
    ];

    return rawList
        .map((item) => item.copyWith(isSaved: isBookmarked(item.id)))
        .toList();
  }

  List<DevotionalItem> getAllItems() {
    return [getVerseOfTheDay(), ...getBhaktiItems(), ...getFestivals()];
  }

  List<DevotionalItem> getSavedItems() {
    final all = getAllItems();
    final seenIds = <String>{};
    final result = <DevotionalItem>[];

    for (final item in all) {
      if (_bookmarkedIds.contains(item.id) && !seenIds.contains(item.id)) {
        seenIds.add(item.id);
        result.add(item.copyWith(isSaved: true));
      }
    }
    return result;
  }
}
