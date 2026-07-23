import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart'; // Opcjonalnie, jeśli używasz do nagłówków

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'KALENDARZ PFK 2026',
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Pasek informacyjny
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: const Color(0xFF1E1E1E),
            child: const Text(
              'Poniższy kalendarz ma charakter poglądowy. Organizatorzy zastrzegają sobie prawo do zmian. Przesuń i przybliż, aby powiększyć.',
              style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),

          // Główny obszar z grafiką (z opcją przybliżania)
          Expanded(
            child: InteractiveViewer(
              minScale: 1.0, // Minimalne przybliżenie (100%)
              maxScale: 4.0, // Maksymalne przybliżenie (400%)
              // SingleChildScrollView pozwala przewijać długi zrzut w dół
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/kalendarz_pfk.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                  color: Colors.grey[400],
                  colorBlendMode: BlendMode.multiply,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: const Text('Brak pliku graficznego kalendarza.', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ),
            ),
          ),

          // Przycisk kierujący do oficjalnej strony na samym dole ekranu
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(top: BorderSide(color: Colors.white12, width: 1)),
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.language),
              label: const Text(
                'SPRAWDŹ OFICJALNĄ STRONĘ PFK',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 0.5),
              ),
              onPressed: () async {
                // Link do strony kalendarza OYAMA PFK
                final Uri url = Uri.parse('https://oyama-karate.pl/artykul.php?id=d1');
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  debugPrint('Nie udało się otworzyć linku: $url');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}