import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'karate_data.dart';
import 'kata_detail_screen.dart'; // Import ekranu Kata

class BeltDetailScreen extends StatelessWidget {
  final Belt belt;

  const BeltDetailScreen({super.key, required this.belt});

  // ==========================================================
  // GŁÓWNY "MÓZG" KLIKNIĘĆ - kieruje ruch do odpowiednich akcji
  // ==========================================================
  void _handleItemTap(BuildContext context, String item) {
    // 1. Sprawdzamy, czy kliknięto KATA (Dla testu: Kai-Ha)
    if (item.contains('Kai-Ha')) {
      Kata? foundKata;
      try {
        // Docelowo aplikacja przeszuka listę układów
        foundKata = KarateData.oyamaKatas
            .expand((category) => category.katas)
            .firstWhere((k) => k.name.contains('Kai-Ha'));
      } catch (e) {
        // ZAŚLEPKA TESTOWA: Jeśli Kai-Ha nie ma jeszcze w bazie
        foundKata = Kata(
          name: 'Kai-Ha (Wersja Testowa)',
          youtubeUrl: 'https://www.youtube.com/watch?v=TWójLinkTestowy', // Tu możesz wstawić byle jaki film
          moves: [
            KataMove(instruction: "Testowy ruch 1"),
            KataMove(instruction: "Testowy ruch 2"),
          ],
        );
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KataDetailScreen(kata: foundKata!),
        ),
      );
    }
    // 2. Sprawdzamy, czy kliknięto TECHNIKĘ (Ushiro Tobi Geri)
    else if (item.contains('USHIRO-TOBI-GERI')) {
      _showTechniqueBottomSheet(
        context,
        title: 'Ushiro Tobi Geri',
        translation: 'Kopnięcie obrotowe z wyskoku w tył',
        description: 'Zaawansowana, bardzo dynamiczna technika polegająca na obrocie ciała w powietrzu i zadaniu ciosu piętą. Wymaga doskonałej koordynacji, wyczucia dystansu oraz timingu.',
        imagePath: 'assets/images/ushiro_tobi_geri_chudan.png', // Ścieżka do Twojego obrazka
      );
    }
    // 3. Jeśli to zwykły tekst bez podpiętej akcji
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Szczegóły dla tego elementu pojawią się wkrótce!'),
          backgroundColor: Colors.white24,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  // ==========================================================
  // WYSUWANY PANEL DLA TECHNIKI (Bottom Sheet)
  // ==========================================================
  void _showTechniqueBottomSheet(BuildContext context, {
    required String title,
    required String translation,
    required String description,
    required String imagePath,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      isScrollControlled: true, // Pozwala panelowi zająć więcej miejsca jeśli trzeba
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, MediaQuery.of(context).padding.bottom + 20), // Dolny margines
          child: Column(
            mainAxisSize: MainAxisSize.min, // Zmienia wysokość w zależności od treści
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pasek do przeciągania na samej górze
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Tytuł japoński
              Text(
                title,
                style: const TextStyle(color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              // Tłumaczenie polskie
              Text(
                translation,
                style: const TextStyle(color: Colors.white54, fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              // ZDJĘCIE TECHNIKI
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  // Zabezpieczenie: jeśli ścieżka do obrazka jest zła, wyświetli szare pole z ikoną
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.black45,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, color: Colors.white24, size: 50),
                          SizedBox(height: 10),
                          Text('Brak obrazka w folderze', style: TextStyle(color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Opis techniki
              Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // BUDOWA EKRANU Z WYMAGANIAMI
  // ==========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          belt.name,
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(color: Colors.amber, letterSpacing: 1.5),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.amber),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: belt.requirements.keys.length,
        itemBuilder: (context, index) {
          String category = belt.requirements.keys.elementAt(index);
          List<String> items = belt.requirements[category]!;

          return Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                ...items.map((item) {
                  // LOGIKA WIZUALNA: Jeśli nazwa zawiera jedno z tych słów, podświetlamy ją!
                  bool isClickable = item.contains('Kai-Ha') || item.contains('USHIRO-TOBI-GERI');

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () => _handleItemTap(context, item),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          // Klikalne elementy zyskują delikatne złote tło i ramkę
                          color: isClickable ? Colors.amber.withOpacity(0.08) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isClickable ? Border.all(color: Colors.amber.withOpacity(0.3)) : null,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "• ",
                              style: TextStyle(
                                  color: isClickable ? Colors.amber : Colors.white54,
                                  fontSize: 18
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isClickable ? Colors.amber.shade200 : Colors.white,
                                  fontSize: 16,
                                  height: 1.4,
                                  fontWeight: isClickable ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isClickable)
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 2.0),
                                child: Icon(Icons.touch_app, color: Colors.amber, size: 18),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const Divider(color: Colors.white10, height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}