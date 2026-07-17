import 'package:flutter/material.dart';
import 'app_dictionary.dart';

// Klasa reprezentująca konkretny stopień (np. 9 KYU junior)
class Rank {
  final String name;
  final String description; // Np. "biały pas z czerwonym pagonem"
  final int redStripes;     // Pagony juniorskie
  final Color? mainStripe;  // Główny pagon seniora (np. czarny na brązowym pasie)

  Rank({
    required this.name,
    required this.description,
    this.redStripes = 0,
    this.mainStripe,
  });
}

// Klasa grupująca stopnie pod jednym kolorem pasa
class BeltGroup {
  final String colorName;
  final Color beltColor;
  final List<Rank> ranks;

  BeltGroup({
    required this.colorName,
    required this.beltColor,
    required this.ranks,
  });
}

// --- NOWA KLASA DLA POJEDYNCZEGO RUCHU W KATA (VIDEO) ---
class KataMove {
  final String instruction;
  final double? startSeconds;  // Zmiana z int na double (pozwala na ułamki, np. 16.5)
  final double? endSeconds;    // Zmiana z int na double

  KataMove({
    required this.instruction,
    this.startSeconds,
    this.endSeconds,
  });
}

// Zaktualizowana klasa Kata
class Kata {
  final String name;
  final String? description;
  final String? startPosition;
  final List<KataMove> moves;
  final String? endPosition;
  final String? youtubeUrl;    // <-- TO MUSI TU BYĆ, aby działało wyświetlanie filmików z youtuba do kata

  Kata({
    required this.name,
    this.description,
    this.startPosition,
    this.moves = const [],
    this.endPosition,
    this.youtubeUrl, // <-- ORAZ TO MUSI BYĆ TUTAJ, aby działało wyświetlanie filmików z youtuba do kata
  });
}

class KataCategory {
  final String title;
  final List<Kata> katas;

  KataCategory({required this.title, required this.katas});
}

class Belt {
  final String name;
  final Map<String, List<String>> requirements;

  Belt({
    required this.name,
    required this.requirements,
  });
}

// ==========================================
// STRUKTURA DANYCH DLA TECHNIK
// ==========================================

class Technique {
  final String name;
  final String translation;
  final String description;
  final String imagePath;

  Technique({
    required this.name,
    required this.translation,
    required this.description,
    required this.imagePath,
  });
}

class TechniqueCategory {
  final String title;
  final List<Technique> techniques;

  TechniqueCategory({
    required this.title,
    required this.techniques,
  });
}

class KarateData {
  // ==========================================
  // OYAMA KARATE
  // ==========================================

  // OYAMA - DO 14 LAT
  static List<BeltGroup> oyamaJuniorBelts = [
    BeltGroup(
      colorName: 'BIAŁY PAS', //TUTAJ MOŻE SIĘ ZMIENIĆ PAS I PAGONY W NAJBLIŻSZYM CZASIE - FLAGA DLA MNIEEEEEEE
      beltColor: Colors.white,
      ranks: [
        Rank(name: '10 KYU', description: '(biały pas z czerwonym pagonem)', redStripes: 1),
        Rank(name: '9 KYU junior', description: '(biały pas z 2 czerwonymi pagonami)', redStripes: 2),
        Rank(name: '9 KYU senior', description: '(biały pas z 3 czerwonymi pagonami)', redStripes: 3),
        Rank(name: '8 KYU junior', description: '(biały pas z 4 czerwonymi pagonami)', redStripes: 4),
        ],
    ),
    BeltGroup(
      colorName: 'NIEBIESKI PAS',
      beltColor: Colors.blue.shade700,
      ranks: [
        Rank(name: '8 KYU senior', description: '(niebieski pas)'),
        Rank(name: '7 KYU junior', description: '(niebieski pas z czerwonym pagonem)', redStripes: 1),
        Rank(name: '7 KYU senior', description: '(niebieski pas z 2 czerwonymi pagonami)', redStripes: 2),
        Rank(name: '6 KYU junior', description: '(niebieski pas z 3 czerwonymi pagonami)', redStripes: 3),
      ],
    ),
    BeltGroup(
      colorName: 'ŻÓŁTY PAS',
      beltColor: Colors.yellow.shade600,
      ranks: [
        Rank(name: '6 KYU senior', description: '(żółty pas)'),
        Rank(name: '5 KYU junior', description: '(żółty pas z czerwonym pagonem)', redStripes: 1),
      ],
    ),
    BeltGroup(
      colorName: 'POMARAŃCZOWY PAS',
      beltColor: Colors.orange.shade800,
      ranks: [
        Rank(name: '5 KYU senior', description: '(pomarańczowy pas)'),
        Rank(name: '4 KYU junior', description: '(pomarańczowy pas z czerwonym pagonem)', redStripes: 1),
      ],
    ),
    BeltGroup(
      colorName: 'ZIELONY PAS',
      beltColor: Colors.green.shade700,
      ranks: [
        Rank(name: '4 KYU senior', description: '(zielony pas)'),
        Rank(name: '3 KYU junior', description: '(zielony pas z czerwonym pagonem)', redStripes: 1),
        Rank(name: '3 KYU senior', description: '(zielony pas z 2 czerwonymi pagonami)', redStripes: 2),
        Rank(name: '2 KYU junior', description: '(zielony pas z 3 czerwonymi pagonami)', redStripes: 3),
      ],
    ),
    BeltGroup(
      colorName: 'BRĄZOWY PAS',
      beltColor: Colors.brown.shade700,
      ranks: [
        Rank(name: '2 KYU senior', description: '(brązowy pas)'),
      ],
    ),
  ];

  // OYAMA - DOROŚLI (Zgodnie z książeczką)
  static List<BeltGroup> oyamaSeniorBelts = [
    BeltGroup(
      colorName: 'BIAŁY PAS',
      beltColor: Colors.white,
      ranks: [
        Rank(name: '10 KYU', description: '(biały pas)'),
        Rank(name: '9 KYU', description: '(biały pas z niebieskim pagonem)', mainStripe: Colors.blue.shade700),
      ],
    ),
    BeltGroup(
      colorName: 'NIEBIESKI PAS',
      beltColor: Colors.blue.shade700,
      ranks: [
        Rank(name: '8 KYU', description: '(niebieski pas)'),
        Rank(name: '7 KYU', description: '(niebieski pas z żółtym pagonem)', mainStripe: Colors.yellow.shade600),
      ],
    ),
    BeltGroup(
      colorName: 'ŻÓŁTY PAS',
      beltColor: Colors.yellow.shade600,
      ranks: [
        Rank(name: '6 KYU', description: '(żółty pas)'),
      ],
    ),
    BeltGroup(
      colorName: 'POMARAŃCZOWY PAS',
      beltColor: Colors.orange.shade800,
      ranks: [
        Rank(name: '5 KYU', description: '(pomarańczowy pas)'),
      ],
    ),
    BeltGroup(
      colorName: 'ZIELONY PAS',
      beltColor: Colors.green.shade700,
      ranks: [
        Rank(name: '4 KYU', description: '(zielony pas)'),
        Rank(name: '3 KYU', description: '(zielony pas z brązowym pagonem)', mainStripe: Colors.brown.shade700),
      ],
    ),
    BeltGroup(
      colorName: 'BRĄZOWY PAS',
      beltColor: Colors.brown.shade700,
      ranks: [
        Rank(name: '2 KYU', description: '(brązowy pas)'),
        Rank(name: '1 KYU', description: '(brązowy pas z czarnym pagonem)', mainStripe: Colors.black),
      ],
    ),
  ];

  // ==========================================
  // KYOKUSHIN KARATE
  // ==========================================

  // KYOKUSHIN - DO 14 LAT
  static List<BeltGroup> kyokushinJuniorBelts = [
    BeltGroup(
      colorName: 'POMARAŃCZOWY PAS',
      beltColor: Colors.orange.shade800,
      ranks: [
        Rank(name: '10.1 KYU', description: '(1 czerwony pagon)', redStripes: 1),
        Rank(name: '10.2 KYU', description: '(2 czerwone pagony)', redStripes: 2),
        Rank(name: '9.1 KYU', description: '(niebieska belka, 1 czerwony pagon)', mainStripe: Colors.blue.shade700, redStripes: 1),
      ],
    ),
    // Tutaj można dodać kolejne juniorskie w przyszłości, jeśli zajdzie potrzeba
  ];

  // KYOKUSHIN - DOROŚLI (Klasyczny podział IKO/KWF)
  static List<BeltGroup> kyokushinSeniorBelts = [
    BeltGroup(
      colorName: 'POMARAŃCZOWY PAS',
      beltColor: Colors.orange.shade800,
      ranks: [
        Rank(name: '10 KYU', description: '(pomarańczowy pas)'),
        Rank(name: '9 KYU', description: '(pomarańczowy pas z niebieskim pagonem)', mainStripe: Colors.blue.shade700),
      ],
    ),
    BeltGroup(
      colorName: 'NIEBIESKI PAS',
      beltColor: Colors.blue.shade700,
      ranks: [
        Rank(name: '8 KYU', description: '(niebieski pas)'),
        Rank(name: '7 KYU', description: '(niebieski pas z żółtym pagonem)', mainStripe: Colors.yellow.shade600),
      ],
    ),
    BeltGroup(
      colorName: 'ŻÓŁTY PAS',
      beltColor: Colors.yellow.shade600,
      ranks: [
        Rank(name: '6 KYU', description: '(żółty pas)'),
        Rank(name: '5 KYU', description: '(żółty pas z zielonym pagonem)', mainStripe: Colors.green.shade700),
      ],
    ),
    BeltGroup(
      colorName: 'ZIELONY PAS',
      beltColor: Colors.green.shade700,
      ranks: [
        Rank(name: '4 KYU', description: '(zielony pas)'),
        Rank(name: '3 KYU', description: '(zielony pas z brązowym pagonem)', mainStripe: Colors.brown.shade700),
      ],
    ),
    BeltGroup(
      colorName: 'BRĄZOWY PAS',
      beltColor: Colors.brown.shade700,
      ranks: [
        Rank(name: '2 KYU', description: '(brązowy pas)'),
        Rank(name: '1 KYU', description: '(brązowy pas z czarnym pagonem)', mainStripe: Colors.black),
      ],
    ),
  ];

  // ==========================================
  // LISTA WYMAGAŃ NA PASY (DOROŚLI OYAMA)
  // ==========================================
  static List<Belt> oyamaAdultBelts = [

    // --- Wymagania 2 KYU ---
    Belt(
      name: '2 KYU (brązowy pas)',
      requirements: {
        AppDictionary.requiredTrainingPeriod: [
          '9 miesięcy',
        ],
        AppDictionary.kicks: [
          'USHIRO-MAWASHI-GERI-JODAN z pozycji walki',
        ],
        AppDictionary.formalKatas: [
          'Kihon-Kata-Sono-Hachi (8)',
        ],
        AppDictionary.weaponKatas: [
          'Tonfa-Kihon-Sono-Ichi',
          'Tonfa-Kihon-Sono-Ni',
          'Bo-Kihon-Sono-Ichi',
          'Bo-Kihon-Sono-Ni',
        ],
        AppDictionary.taskKumite: [
          'Walka ze zmieniającymi się partnerami: 10 x 2 minuty',
        ],
      },
    ),

    // --- Wymagania 1 KYU ---
    Belt(
      name: '1 KYU (brązowy pas z 1 czarnym pagonem)',
      requirements: {
        AppDictionary.requiredTrainingPeriod: [
          '9-12 miesięcy',
          AppDictionary.minimumAge16,
        ],
        AppDictionary.kicks: [
          'USHIRO-MAWASHI-GERI-GEDAN z pozycji walki',
          'USHIRO-TOBI-GERI-CHUDAN',
          'USHIRO-MAWASHI-TOBI-GERI-JODAN (${AppDictionary.notPartOfExam})',
        ],
        AppDictionary.formalKatas: [
          'Kai-Ha',
          'Kumite-No-Kata-Sono-San (3)',
        ],
        AppDictionary.weaponKatas: [
          'Tonfa-Kihon-Sono-San',
          'Tsion (Bo)',
        ],
        AppDictionary.taskKumite: [
          'Walka ze zmieniającymi się partnerami: 12 x 2 min',
        ],
      },
    ),
  ];
  // ==========================================
  // LISTA KATA (Na razie wpisujemy ułożenie dla Oyamy)
  // ==========================================
  static List<KataCategory> oyamaKatas = [
    KataCategory(
        title: 'Kihon Kata (Podstawowe)',
        katas: [
          Kata(
            name: 'Kihon Kata Sono Ichi',
            youtubeUrl: 'https://www.youtube.com/watch?v=IcKv0WtU6Qk',
            startPosition: 'Fudo-Dachi / Yoi',
            endPosition: 'Yame (lewą nogę cofnij do prawej i przesuń w bok do pozycji Fudo-Dachi).',
            moves: [
              // Symulujemy, że sprawdziłeś wideo i ten ruch jest od 12 do 15 sekundy
              KataMove(
                instruction: 'Obrót 90° w lewo z wejściem do Hidari-Zenkutsu-Dachi / Hidari-Uraken-Ganmen-Uchi / Seiken-Chudan-Gyaku-Tsuki / Kiai.',
                startSeconds: 12,
                endSeconds: 15.7,
              ),
              KataMove(
                instruction: 'Obrót 180° w prawo (prawą nogę przesuń w prawo po skosie w tył) do pozycji Migi-Zenkutsu-Dachi / Migi-Uraken-Ganmen-Uchi / Seiken-Chudan-Gyaku-Tsuki / Kiai.',
                startSeconds: 16,
                endSeconds: 18,
              ),
              // Jeśli kiedyś nie będziesz znał czasu jakiegoś ruchu, po prostu go nie podajesz
              KataMove(
                instruction: 'Obrót 90° w lewo do pozycji walki Kiai.',
                startSeconds: 18,
                endSeconds: 20,
              ),
              KataMove(instruction: 'Migi-Mae-Geri-Jodan (po kopnięciu wejdź do prawej pozycji walki).'),
              KataMove(instruction: 'Hidari-Mae-Geri-Jodan (po kopnięciu wejdź do lewej pozycji walki).'),
              KataMove(instruction: 'Migi-Mae-Geri-Jodan / po kopnięciu wejdź do Migi-Zenkutsu-Dachi / Migi-Uraken-Ganmen-Uchi / Seiken-Chudan-Gyaku-Tsuki / Kiai.'),
              KataMove(instruction: 'Obrót 180° w lewo do lewej pozycji walki/ Kiai.'),
              KataMove(instruction: 'Migi-Mae-Geri-Jodan (po kopnięciu wejdź do prawej pozycji walki).'),
              KataMove(instruction: 'Hidari-Mae-Geri-Jodan (po kopnięciu wejdź do lewej pozycji walki).'),
              KataMove(instruction: 'Migi-Mae-Geri-Jodan / po kopnięciu wejdź do Migi-Zenkutsu-Dachi / Migi-Uraken-Ganmen-Uchi / Seiken-Chudan-Gyaku-Tsuki / Kiai.'),
              KataMove(instruction: 'Obrót 180° w lewo do lewej pozycji walki/ Kiai.'),
            ],
          ),
          Kata(name: 'Kihon Kata Sono Ni'),
          Kata(name: 'Kihon Kata Sono San'),
          Kata(name: 'Kihon Kata Sono Yon'),
          Kata(name: 'Kihon Kata Sono Go'),
          // Celowo pominięte (6), bo nikt nigdy tego nie robi
          Kata(name: 'Kihon Kata Sono Nana'),
          Kata(name: 'Kihon Kata Sono Hachi'),
        ]
    ),
    KataCategory(
        title: 'Kumite No Kata',
        katas: [
          Kata(name: 'Kumite No Kata Sono Ichi'),
          Kata(name: 'Kumite No Kata Sono Ni'),
          Kata(name: 'Kumite No Kata Sono San'),
        ]
    ),
    KataCategory(
        title: 'Kata Tradycyjne (Wyższe)',
        katas: [
          Kata(name: 'Kai-Ha'),
          Kata(name: 'Seichin'),
          Kata(name: 'Kanku Dai'),
        ]
    ),
    KataCategory(
        title: 'Kobudo (Praca z bronią)',
        katas: [
          Kata(name: 'Tonfa Kihon Sono Ichi', description: 'Broń: Tonfa'),
          Kata(name: 'Tonfa Kihon Sono Ni', description: 'Broń: Tonfa'),
          Kata(name: 'Tonfa Kihon Sono San', description: 'Broń: Tonfa'),
          Kata(name: 'Tonfa Taizan', description: 'Broń: Tonfa'),
          Kata(name: 'Bo Kihon Sono Ichi', description: 'Broń: Kij (Bo)'),
          Kata(name: 'Bo Kihon Sono Ni', description: 'Broń: Kij (Bo)'),
          Kata(name: 'Bo Tsion', description: 'Broń: Kij (Bo)'),
          Kata(name: 'Bo Soki', description: 'Broń: Kij (Bo)'),
        ]
    ),
  ];
  // ==========================================
  // LISTA KATA DLA KYOKUSHIN
  // ==========================================
  static List<KataCategory> kyokushinKatas = [
    KataCategory(
        title: 'Taikyoku Kata',
        katas: [
          Kata(name: 'Taikyoku Sono Ichi'),
          Kata(name: 'Taikyoku Sono Ni'),
          Kata(name: 'Taikyoku Sono San'),
        ]
    ),
    KataCategory(
        title: 'Pinan Kata',
        katas: [
          Kata(name: 'Pinan Sono Ichi'),
          Kata(name: 'Pinan Sono Ni'),
          Kata(name: 'Pinan Sono San'),
          Kata(name: 'Pinan Sono Yon'),
          Kata(name: 'Pinan Sono Go'),
        ]
    ),
    KataCategory(
        title: 'Kata Tradycyjne (Wyższe)',
        katas: [
          Kata(name: 'Sanchin No Kata'),
          Kata(name: 'Yantsu'),
          Kata(name: 'Tsuki No Kata'),
          Kata(name: 'Gekisai Dai'),
          Kata(name: 'Gekisai Sho'),
        ]
    ),
  ];

  // ==========================================
  // BAZA TECHNIK (MVP z książeczki 2010)
  // ==========================================
  static final List<TechniqueCategory> oyamaTechniques = [
    TechniqueCategory(
      title: "Broń Karate",
      techniques: [
        Technique(
          name: "SEIKEN",
          translation: "Pięść",
          description: "Podstawowa broń w karate. Uderza się powierzchnią dwóch pierwszych kostek (wskazującego i środkowego palca). Kciuk musi mocno dopinać zaciśnięte palce od dołu.",
          imagePath: "assets/images/tech_seiken.png",
        ),
        Technique(
          name: "URAKEN",
          translation: "Odwrócona pięść",
          description: "Uderzenie 'grzbietem' pięści, najczęściej wykonywane z dużą szybkością po łuku. Wykorzystywane do szybkich ataków na korpus przeciwnika.",
          imagePath: "assets/images/tech_uraken.png",
        ),
        Technique(
          name: "HIZA",
          translation: "Kolano",
          description: "Bardzo potężna broń w półdystansie i zwarciu. Uderzenie kolanem (Hiza-geri) potrafi wygenerować ogromną siłę, szczególnie przy ściągnięciu głowy/korpusu przeciwnika w dół.",
          imagePath: "assets/images/tech_hiza.png",
        ),
      ],
    ),
    TechniqueCategory(
      title: "Pozycje",
      techniques: [
        Technique(
          name: "Zenkutsu-dachi",
          translation: "Pozycja wykroczna",
          description: "Ciężar ciała w 70% na nodze przedniej, mocno ugiętej. Noga tylna prosta, stopa skręcona lekko na zewnątrz. Bardzo stabilna pozycja do silnych ataków w przód.",
          imagePath: "assets/images/tech_zenkutsu.png",
        ),
        Technique(
          name: "Kiba-dachi",
          translation: "Pozycja jeźdźca",
          description: "Ciężar ciała rozłożony równomiernie (50/50) na obu nogach. Stopy równoległe, kolana mocno ugięte i wypchnięte na zewnątrz. Przypomina dosiadanie konia.",
          imagePath: "assets/images/tech_kiba.png",
        ),
        Technique(
          name: "Kokutsu-dachi",
          translation: "Pozycja zakroczna",
          description: "Ciężar ciała przeniesiony w 70% na nogę tylną. Przednia noga opiera się lekko na chusoku (poduszce stopy). Idealna pozycja do blokowania i szybkich kontrataków z przedniej nogi.",
          imagePath: "assets/images/tech_kokutsu.png",
        ),
      ],
    ),
    TechniqueCategory(
      title: "Techniki ręczne",
      techniques: [
        Technique(
          name: "Gedan-barai",
          translation: "Blok dolny",
          description: "Podstawowy blok przedłużonym ramieniem przed kopnięciami w strefę dolną. Ruch rozpoczyna się od przeciwnego ucha i idzie łukiem w dół nad kolano.",
          imagePath: "assets/images/tech_gedan_barai.png",
        ),
        Technique(
          name: "Jodan-uke",
          translation: "Blok górny",
          description: "Blok chroniący głowę przed uderzeniami z góry. Przedramię unosi się nad czoło pod kątem, by cios ześlizgnął się po ręce.",
          imagePath: "assets/images/tech_jodan_uke.png",
        ),
        Technique(
          name: "Seiken-chudan-tsuki",
          translation: "Cios prosty (strefa środkowa)",
          description: "Klasyczne uderzenie proste pięścią z biodra na wysokość splotu słonecznego. Wymaga mocnego skrętu bioder i jednoczesnego wycofania drugiej ręki do hikite.",
          imagePath: "assets/images/tech_seiken_tsuki.png",
        ),
      ],
    ),
    TechniqueCategory(
      title: "Kopnięcia",
      techniques: [
        Technique(
          name: "Mae-geri-jodan",
          translation: "Kopnięcie w przód na głowę",
          description: "Wyprowadzenie wysokiego kopnięcia prosto przed siebie. Kluczowe jest mocne podciągnięcie kolana do klatki piersiowej przed wyprostem nogi.",
          imagePath: "assets/images/tech_mae_geri.png",
        ),
        Technique(
          name: "Mawashi-geri-jodan",
          translation: "Kopnięcie okrężne na głowę",
          description: "Jedna z najskuteczniejszych technik w walce. Kopnięcie po łuku, trafiające w głowę lub szyję przeciwnika. Wymaga doskonałej elastyczności i skrętu biodra stopy podporowej.",
          imagePath: "assets/images/tech_mawashi_geri.png",
        ),
        Technique(
          name: "Ushiro-geri",
          translation: "Kopnięcie w tył",
          description: "Bardzo silne kopnięcie wykonywane piętą w tył. Często stosowane po obrocie jako technika zaskakująca. Wymaga spojrzenia przez ramię przed trafieniem.",
          imagePath: "assets/images/tech_ushiro_geri.png",
        ),
      ],
    ),
    TechniqueCategory(
      title: "Inne",
      techniques: [
        Technique(
          name: "Wiązanie pasa",
          translation: "Tradycyjny węzeł Obi",
          description: "Pas w Karate to symbol wiedzy i ciężkiej pracy. Należy go wiązać tak, by oba końce po zawiązaniu węzła miały identyczną długość. Węzeł powinien być płaski i mocny.",
          imagePath: "assets/images/tech_wiazanie_pasa.png",
        ),
        Technique(
          name: "Składanie Karate Gi",
          translation: "Szacunek do stroju",
          description: "Dogi składa się w specyficzny sposób, formując z niego estetyczną kostkę lub zawijając w pas. Wyraża to szacunek do dyscypliny i zapobiega gnieceniu się materiału.",
          imagePath: "assets/images/tech_skladanie_gi.png",
        ),
      ],
    ),
  ];
}

