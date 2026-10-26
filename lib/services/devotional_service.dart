import '../models/devotional_item.dart';

class DevotionalService {
  DevotionalItem getVerseOfTheDay() {
    return const DevotionalItem(
      id: 'v_day_1',
      title: 'Bhagavad Gita 2.47',
      subtitle: 'Karma Yoga',
      content:
          'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।\nमा कर्मफलहेतुर्भूर्मा ते सङ्गोऽस्त्वकर्मणि॥\n\n'
          'You have a right to perform your prescribed duty, but you are not entitled to the fruits of action.',
      category: 'Verse',
      deity: 'Shri Krishna',
      isSaved: true,
    );
  }

  Map<String, String> getTodayPanchang() {
    return {
      'tithi': 'Shukla Paksha Ekadashi',
      'nakshatra': 'Rohini',
      'samvat': 'Vikram Samvat 2081',
      'day': 'Aaj Ka Panchang',
      'sunrise': '06:28 AM',
      'sunset': '06:12 PM',
    };
  }

  List<DevotionalItem> getBhaktiItems() {
    return const [
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
        content:
            'ॐ भूर्भुवः स्वः तत्सवितुर्वरेण्यं भर्गो देवस्य धीमहि धियो यो नः प्रचोदयात्॥',
        category: 'Mantra',
        deity: 'Gayatri Devi',
        isSaved: true,
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
        content:
            'जटाटवीगलज्जलप्रवाहपावितस्थले गलेऽवलम्ब्य लम्बितां भुजङ्गतुङ्गमालिकाम्॥',
        category: 'Stotram',
        deity: 'Shiva',
      ),
    ];
  }

  List<DevotionalItem> getFestivals() {
    return const [
      DevotionalItem(
        id: 'f_1',
        title: 'Maha Shivratri',
        subtitle: 'The Great Night of Shiva',
        content:
            'Celebrated in honor of Lord Shiva. Fasting and night-long vigil (Jagran) are observed by devotees.',
        category: 'Festival',
        date: 'Upcoming • Phalguna Krishna Chaturdashi',
      ),
      DevotionalItem(
        id: 'f_2',
        title: 'Holi',
        subtitle: 'Festival of Colors & Spring',
        content:
            'Signifies the victory of good over evil with Holika Dahan followed by Rangwali Holi.',
        category: 'Festival',
        date: 'Upcoming • Phalguna Purnima',
      ),
      DevotionalItem(
        id: 'f_3',
        title: 'Ram Navami',
        subtitle: 'Birth of Lord Shri Ram',
        content:
            'Marks the birth of Lord Ram in Ayodhya. Recitation of Ramayana and special pujas take place.',
        category: 'Festival',
        date: 'Upcoming • Chaitra Shukla Navami',
      ),
      DevotionalItem(
        id: 'f_4',
        title: 'Diwali',
        subtitle: 'Festival of Lights',
        content:
            'Celebrates Lord Ram\'s return to Ayodhya and Lakshmi Puja for wisdom and prosperity.',
        category: 'Festival',
        date: 'Kartik Amavasya',
      ),
    ];
  }

  List<DevotionalItem> getSavedItems() {
    return const [
      DevotionalItem(
        id: 'v_day_1',
        title: 'Bhagavad Gita 2.47',
        subtitle: 'Karma Yoga',
        content:
            'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।\nमा कर्मफलहेतुर्भूर्मा ते सङ्गोऽस्त्वकर्मणि॥',
        category: 'Verse',
        deity: 'Shri Krishna',
        isSaved: true,
      ),
      DevotionalItem(
        id: 'b_3',
        title: 'Gayatri Mantra',
        subtitle: 'Universal Prayer for Enlightenment',
        content:
            'ॐ भूर्भुवः स्वः तत्सवितुर्वरेण्यं भर्गो देवस्य धीमहि धियो यो नः प्रचोदयात्॥',
        category: 'Mantra',
        deity: 'Gayatri Devi',
        isSaved: true,
      ),
    ];
  }
}
