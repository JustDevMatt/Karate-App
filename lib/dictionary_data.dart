// --- 1. KATEGORIE SŁOWNIKA (Zgodne ze zdjęciem) ---
enum DictCategory {
  numbers('Liczebniki / Wymowa'),
  weapons('Broń w karate'),
  zones('Strefy / Kierunek / Cel'),
  other('Inne');

  final String label;
  const DictCategory(this.label);
}

// --- 2. MODEL SŁÓWKA ---
class DictionaryItem {
  final String japanese;
  final String polish;
  final DictCategory category;

  const DictionaryItem({
    required this.japanese,
    required this.polish,
    required this.category,
  });
}

// --- 3. PEŁNA BAZA SŁÓWEK OYAMA KARATE (Zgodna z podręcznikiem) ---
const List<DictionaryItem> oyamaDictionary = [
  // ==========================================
  // 1. LICZEBNIKI / WYMOWA
  // ==========================================
  DictionaryItem(japanese: 'ICHI (Ichi)', polish: '1', category: DictCategory.numbers),
  DictionaryItem(japanese: 'NI (Ni)', polish: '2', category: DictCategory.numbers),
  DictionaryItem(japanese: 'SAN (San)', polish: '3', category: DictCategory.numbers),
  DictionaryItem(japanese: 'SHI (Si) / YON (Jon)', polish: '4', category: DictCategory.numbers),
  DictionaryItem(japanese: 'GO (Go)', polish: '5', category: DictCategory.numbers),
  DictionaryItem(japanese: 'ROKU (Roku)', polish: '6', category: DictCategory.numbers),
  DictionaryItem(japanese: 'SHICHI (Sici)', polish: '7', category: DictCategory.numbers),
  DictionaryItem(japanese: 'HACHI (Haci)', polish: '8', category: DictCategory.numbers),
  DictionaryItem(japanese: 'KU (Kju)', polish: '9', category: DictCategory.numbers),
  DictionaryItem(japanese: 'JU (Dziu)', polish: '10', category: DictCategory.numbers),
  DictionaryItem(japanese: 'NINJU', polish: '20', category: DictCategory.numbers),
  DictionaryItem(japanese: 'SANJU', polish: '30', category: DictCategory.numbers),
  DictionaryItem(japanese: 'YONJU', polish: '40', category: DictCategory.numbers),
  DictionaryItem(japanese: 'GOJU', polish: '50', category: DictCategory.numbers),
  DictionaryItem(japanese: 'HAYKU', polish: '100', category: DictCategory.numbers),

  // ==========================================
  // 2. BROŃ W KARATE
  // ==========================================
  DictionaryItem(japanese: 'Atama', polish: 'głowa', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Ashi', polish: 'noga', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Bo', polish: 'długi kij', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Chusoku', polish: 'poduszka stopy', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Furi', polish: 'krótki sierp', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Haisoku', polish: 'podbicie stopy', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Haito', polish: 'wewn. kant dłoni', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Hiji', polish: 'łokieć', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Hiza', polish: 'kolano', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Kakato', polish: 'pięta', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Sai', polish: 'sztylet', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Seiken', polish: 'pięść', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Shotei', polish: 'podstawa dłoni', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Shuto', polish: 'kant dłoni', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Shita', polish: 'hak', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Tettsui', polish: 'pięść młot', category: DictCategory.weapons),
  DictionaryItem(japanese: 'Tonfa', polish: 'pałka z rączką', category: DictCategory.weapons),

  // ==========================================
  // 3. STREFY / KIERUNEK / CEL
  // ==========================================
  DictionaryItem(japanese: 'Age', polish: 'w górę', category: DictCategory.zones),
  DictionaryItem(japanese: 'Ago', polish: 'podbródek, szczęka', category: DictCategory.zones),
  DictionaryItem(japanese: 'Chudan', polish: 'korpus, średni poziom', category: DictCategory.zones),
  DictionaryItem(japanese: 'Ganmen', polish: 'twarz', category: DictCategory.zones),
  DictionaryItem(japanese: 'Gedan', polish: 'strefa od pasa w dół', category: DictCategory.zones),
  DictionaryItem(japanese: 'Gyaku', polish: 'przeciwnie, odwrotnie', category: DictCategory.zones),
  DictionaryItem(japanese: 'Hidari', polish: 'w lewo', category: DictCategory.zones),
  DictionaryItem(japanese: 'Hizo', polish: 'żebro', category: DictCategory.zones),
  DictionaryItem(japanese: 'Jodan', polish: 'strefa od barków w górę', category: DictCategory.zones),
  DictionaryItem(japanese: 'Kake', polish: 'zahaczać / hak', category: DictCategory.zones),
  DictionaryItem(japanese: 'Kansetsu', polish: 'staw kolanowy', category: DictCategory.zones),
  DictionaryItem(japanese: 'Kin', polish: 'krocze', category: DictCategory.zones),
  DictionaryItem(japanese: 'Mae', polish: 'w przód', category: DictCategory.zones),
  DictionaryItem(japanese: 'Mawashi', polish: 'okrężnie', category: DictCategory.zones),
  DictionaryItem(japanese: 'Mawatte', polish: 'obrót', category: DictCategory.zones),
  DictionaryItem(japanese: 'Migi', polish: 'w prawo', category: DictCategory.zones),
  DictionaryItem(japanese: 'Naore', polish: 'powrót do pozycji', category: DictCategory.zones),
  DictionaryItem(japanese: 'Oi', polish: 'zgodny', category: DictCategory.zones),
  DictionaryItem(japanese: 'Oroshi', polish: 'z góry w dół', category: DictCategory.zones),
  DictionaryItem(japanese: 'Sakotsu', polish: 'obojczyk', category: DictCategory.zones),
  DictionaryItem(japanese: 'Sayu', polish: 'prawy i lewy', category: DictCategory.zones),
  DictionaryItem(japanese: 'Shomen', polish: 'przód', category: DictCategory.zones),
  DictionaryItem(japanese: 'Soto', polish: 'z zewnątrz', category: DictCategory.zones),
  DictionaryItem(japanese: 'Tobi', polish: 'skakać, w wyskoku', category: DictCategory.zones),
  DictionaryItem(japanese: 'Uchi', polish: 'ze środka, wewnętrzny', category: DictCategory.zones),
  DictionaryItem(japanese: 'Ura', polish: 'odwrotnie', category: DictCategory.zones),
  DictionaryItem(japanese: 'Ushiro', polish: 'tył, w tył', category: DictCategory.zones),
  DictionaryItem(japanese: 'Yoko', polish: 'bok, w bok', category: DictCategory.zones),

  // ==========================================
  // 4. INNE
  // ==========================================
  DictionaryItem(japanese: 'Arigato', polish: 'dziękuję', category: DictCategory.other),
  DictionaryItem(japanese: 'Ashi', polish: 'stopa', category: DictCategory.other),
  DictionaryItem(japanese: 'Barai', polish: 'zagarnięcie', category: DictCategory.other),
  DictionaryItem(japanese: 'Budo', polish: 'sztuki wojenne', category: DictCategory.other),
  DictionaryItem(japanese: 'Dan', polish: 'stopień mistrzowski', category: DictCategory.other),
  DictionaryItem(japanese: 'Do', polish: 'droga, kierunek myśli', category: DictCategory.other),
  DictionaryItem(japanese: 'Dojo', polish: 'miejsce treningu', category: DictCategory.other),
  DictionaryItem(japanese: 'Geri', polish: 'kopać', category: DictCategory.other),
  DictionaryItem(japanese: 'Hanshi', polish: 'nauczyciel mistrzów', category: DictCategory.other),
  DictionaryItem(japanese: 'Hajime', polish: 'zaczynać', category: DictCategory.other),
  DictionaryItem(japanese: 'Ibuki', polish: 'oddychanie', category: DictCategory.other),
  DictionaryItem(japanese: 'Kamaete', polish: 'pozycja rąk', category: DictCategory.other),
  DictionaryItem(japanese: 'Kancho', polish: 'dyrektor', category: DictCategory.other),
  DictionaryItem(japanese: 'Kata', polish: 'ćwiczenia formalne', category: DictCategory.other),
  DictionaryItem(japanese: 'Kiai', polish: 'krzyk bojowy', category: DictCategory.other),
  DictionaryItem(japanese: 'Kiba', polish: 'jeździec', category: DictCategory.other),
  DictionaryItem(japanese: 'Kyu', polish: 'stopień uczniowski', category: DictCategory.other),
  DictionaryItem(japanese: 'Moro', polish: 'obie', category: DictCategory.other),
  DictionaryItem(japanese: 'Moro-Te', polish: 'podwójnie rękami', category: DictCategory.other),
  DictionaryItem(japanese: 'Obi', polish: 'pas', category: DictCategory.other),
  DictionaryItem(japanese: 'Oesh (Oś)', polish: 'tak, dziękuję, pozdrowienie', category: DictCategory.other),
  DictionaryItem(japanese: 'Osae', polish: 'ściągać w dół', category: DictCategory.other),
  DictionaryItem(japanese: 'Sanchin', polish: 'trójkąt sił', category: DictCategory.other),
  DictionaryItem(japanese: 'Sansei', polish: 'nauczyciel', category: DictCategory.other),
  DictionaryItem(japanese: 'Seiza', polish: 'siedzenie na piętach', category: DictCategory.other),
  DictionaryItem(japanese: 'Sempai', polish: 'starszy uczeń', category: DictCategory.other),
  DictionaryItem(japanese: 'Shihan', polish: 'mistrz od 5 dana', category: DictCategory.other),
  DictionaryItem(japanese: 'Soshu', polish: 'założyciel, szef', category: DictCategory.other),
  DictionaryItem(japanese: 'Te', polish: 'ręce', category: DictCategory.other),
  DictionaryItem(japanese: 'Tameshiwari', polish: 'łamanie desek', category: DictCategory.other),
  DictionaryItem(japanese: 'Tsuki', polish: 'pchać / uderzać', category: DictCategory.other),
  DictionaryItem(japanese: 'Uchi', polish: 'ciąć / uderzać', category: DictCategory.other),
  DictionaryItem(japanese: 'Yame', polish: 'stop', category: DictCategory.other),
  DictionaryItem(japanese: 'Yoi', polish: 'gotowy', category: DictCategory.other),
];