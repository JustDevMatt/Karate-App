import 'dart:io';

class AppDictionary {
  // Zmienna, która przy uruchomieniu sprawdza, czy telefon działa w języku polskim
  static bool isPolish = Platform.localeName.startsWith('pl');

  // Skrócona logika if/else: (czy_polski) ? 'TAK' : 'NIE'
  static String get chooseStyle => isPolish ? 'WYBIERZ STYL' : 'CHOOSE YOUR STYLE';

  // Nazwy stylów są takie same na całym świecie
  static String get oyamaKarate => 'OYAMA KARATE';
  static String get kyokushinKarate => 'KYOKUSHIN KARATE';

  // Menu Boczne (Drawer)
  static String get home => isPolish ? 'Wybór Stylu' : 'Home';
  static String get styleHistory => isPolish ? 'Historia Stylu' : 'Style History';
  static String get news => isPolish ? 'Okiem Sportowca' : 'Karate News';
  static String get newsSubtitle => isPolish ? 'Wiadomości ze świata Karate' : 'News from the Karate world';
  static String get support => isPolish ? 'Postaw mi kawę' : 'Buy me a coffee';
  static String get supportSubtitle => isPolish ? 'Wsparcie projektu' : 'Support the project';

  // Dolny Pasek (Bottom Navigation)
  static String get katas => isPolish ? 'KATA' : 'KATAS';
  static String get requirements => isPolish ? 'WYMAGANIA' : 'REQUIREMENTS';
  static String get techniques => isPolish ? 'TECHNIKI' : 'TECHNIQUES';
  static String get flashcards => isPolish ? 'FISZKI' : 'FLASHCARDS';

  // Tymczasowe teksty na środku ekranu
  static String kataSection(String style) => isPolish
      ? 'Sekcja KATA\n(Lista układów formalnych dla:\n$style)'
      : 'KATA Section\n(List of formal patterns for:\n$style)';

  static String reqSection(String style) => isPolish
      ? 'Sekcja WYMAGANIA\nTutaj wlecą pasy dla:\n$style'
      : 'REQUIREMENTS Section\nBelts for:\n$style';

  static String techSection(String style) => isPolish
      ? 'Sekcja TECHNIKI\n(Słownik ciosów dla:\n$style)'
      : 'TECHNIQUES Section\n(Dictionary of strikes for:\n$style)';

  static String flashSection(String style) => isPolish
      ? 'Sekcja FISZKI\n(Trening pamięciowy dla:\n$style)'
      : 'FLASHCARDS Section\n(Memory training for:\n$style)';

  // Zakładki wiekowe
  static String get under14 => isPolish ? 'DO 14 LAT' : 'UNDER 14 YEARS';
  static String get adults => isPolish ? 'DOROŚLI' : 'ADULTS';

  // Sekcje egzaminacyjne i adnotacje
  static const String requiredTrainingPeriod = "Wymagany okres treningów";
  static const String minimumAge16 = "Kandydat musi mieć ukończone 16 lat";
  static const String kicks = "Kopnięcia";
  static const String formalKatas = "Układy formalne";
  static const String weaponKatas = "Układy formalne z bronią";
  static const String taskKumite = "Kumite zadaniowe";
  static const String notPartOfExam = "* Nie jest częścią egzaminu";
}

