import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'belt_screen.dart';
import 'app_dictionary.dart';

void main() {
  runApp(const KarateApp());
}

class KarateApp extends StatelessWidget {
  const KarateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oyama & Kyokushin App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const StyleSelectionScreen(),
    );
  }
}

class StyleSelectionScreen extends StatelessWidget {
  const StyleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppDictionary.chooseStyle, // Zmiana na słownik!
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(
              color: Color(0xFFD4AF37), // Zmieniony, spokojniejszy złoty kolor
              fontWeight: FontWeight.w500,
              letterSpacing: 2.5,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(121212),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StyleCard(
              title: 'OYAMA KARATE',
              imagePath: 'assets/images/oyama.png',
              accentColor: Colors.red.shade800,
              // Przesuwamy tylko grafikę OYAMA, bo takie zdjęcie wybrałem i trzeba to tutaj zrobić
              imageOffset: const Offset(-17, 0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BeltScreen(styleName: 'OYAMA KARATE'),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 2,
            color: Colors.white12,
          ),
          Expanded(
            child: StyleCard(
              title: 'KYOKUSHIN KARATE',
              imagePath: 'assets/images/kyokushin.png',
              accentColor: Colors.blue.shade800,
              // Kyokushin zostaje na środku (Offset 0,0)
              imageOffset: const Offset(0, 0),
              onTap: () {
                // To przenosi nas na nowy ekran z informacją "KYOKUSHIN"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BeltScreen(styleName: 'KYOKUSHIN KARATE'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StyleCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color accentColor;
  final VoidCallback onTap;
  final Offset imageOffset;

  const StyleCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.accentColor,
    required this.onTap,
    required this.imageOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Kontener z poświatą jest teraz na zewnątrz, więc stoi "idealnie" na środku
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Okrągła poświata, aby wyglądało to "fajniej"
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.3),
                      blurRadius: 70,
                      spreadRadius: 25,
                    )
                  ],
                ),
                // 2. Przesuwamy TYLKO obrazek za pomocą Transform.translate
                child: Transform.translate(
                  offset: imageOffset,
                  child: Image.asset(
                    imagePath,
                    height: 150,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                title,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}