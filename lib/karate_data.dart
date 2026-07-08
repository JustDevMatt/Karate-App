import 'package:flutter/material.dart';

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

// --- NOWA KLASA DLA POJEDYNCZEGO RUCHU ---
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
  final String? youtubeUrl;    // <-- TO MUSI TU BYĆ

  Kata({
    required this.name,
    this.description,
    this.startPosition,
    this.moves = const [],
    this.endPosition,
    this.youtubeUrl, // <-- ORAZ TO MUSI BYĆ TUTAJ
  });
}

class KataCategory {
  final String title;
  final List<Kata> katas;

  KataCategory({required this.title, required this.katas});
}


class KarateData {
  // ==========================================
  // OYAMA KARATE
  // ==========================================

  // OYAMA - DO 14 LAT
  static List<BeltGroup> oyamaJuniorBelts = [
    BeltGroup(
      colorName: 'BIAŁY PAS',
      beltColor: Colors.white,
      ranks: [
        Rank(name: '10 KYU', description: '(biały pas)'),
        Rank(name: '9 KYU junior', description: '(biały pas z czerwonym pagonem)', redStripes: 1),
        Rank(name: '9 KYU senior', description: '(biały pas z 2 czerwonymi pagonami)', redStripes: 2),
        Rank(name: '8 KYU junior', description: '(biały pas z 3 czerwonymi pagonami)', redStripes: 3),
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
}