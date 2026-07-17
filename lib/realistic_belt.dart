import 'package:flutter/material.dart';

class RealisticBelt extends StatelessWidget {
  final Color beltColor;
  final int redStripes;    // Ilość czerwonych pagonów juniorskich (0, 1, 2 lub 3)
  final Color? mainStripe; // Kolor głównej belki (np. czarna na 1 kyu)

  const RealisticBelt({
    super.key,
    required this.beltColor,
    this.redStripes = 0,
    this.mainStripe,
  });

  @override
  Widget build(BuildContext context) {
    // Określamy, czy pas jest ciemny, czy jasny, aby dobrać kolor węzła i cieni
    bool isDarkBelt = beltColor.computeLuminance() < 0.3; // computeLuminance zwraca jasność w skali: 0 (czarny) - 1 (biały)

    return Container(
      width: 140,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(2, 2)),
        ],
        // Gradient udający wypukłość materiału
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            beltColor.withOpacity(0.7),
            beltColor,
            beltColor.withOpacity(0.5),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Rysujemy atrapę "węzła" pośrodku pasa
          Center(
            child: Container(
              width: 16,
              decoration: BoxDecoration(
                color: beltColor,
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: isDarkBelt ? Colors.white30 : Colors.black26,
                    width: 1,
                  ),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    beltColor.withOpacity(0.8),
                    beltColor,
                    beltColor.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),

          // Miejsce na pagony po prawej stronie (zaczynamy od prawej krawędzi)
          Positioned(
            right: 15, // Pagon trochę odsunięty od krawędzi
            top: 0,
            bottom: 0,
            child: Row(
              // Ustawiamy elementy od prawej do lewej (tak jak naszywa się pagony)
              textDirection: TextDirection.rtl,
              children: [
                // 1. Główny pagon (belka) - rysujemy go pierwszego z brzegu
                if (mainStripe != null)
                  Container(
                    width: 8, // Szerokość głównej belki
                    color: mainStripe,
                    margin: const EdgeInsets.only(left: 4),
                  ),

                // 2. Czerwone pagony juniorskie - rysujemy ich tyle, ile wynosi 'redStripes'
                for (int i = 0; i < redStripes; i++)
                  Container(
                    width: 4, // Szerokość pagonu juniorskiego
                    color: Colors.red,
                    margin: const EdgeInsets.only(left: 3), // Odstępy między pagonami
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}