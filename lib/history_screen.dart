import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Ciemne tło, spójne z resztą aplikacji
      appBar: AppBar(
        title: Text(
          'HISTORIA STYLU',
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sekcja cytatu
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  border: const Border(left: BorderSide(color: Colors.amber, width: 4)),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      "„Studiowanie karate jest jak wspinanie się na wysoką górę. Życie jest do tego podobne. Ważne jest, aby wytrwale dążyć na sam szczyt. Kiedy go osiągniesz, możesz wiele dostrzec i zrozumieć. Stanie u podnóża góry pozwala jedynie podziwiać jej wierzchołek.”",
                      style: TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "~ Wielki Mistrz Shigeru Oyama 10. Dan",
                      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Nagłówek 1
              const Text(
                "Twórca Stylu",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Tekst na podstawie pierwszej części
              const Text(
                "Twórcą naszego stylu był Wielki Mistrz Shigeru OYAMA (10. Dan) - legenda światowego karate, który po dekadach praktyki i studiowania wschodnich sztuk walki stworzył neoklasyczną dyscyplinę, opartą na japońskiej tradycji oraz najskuteczniejszych formach walki. Soshu Shigeru Oyama był bez wątpienia najwybitniejszym żyjącym mistrzem karate full contact. W ciągu swojej 70-letniej kariery zasłynął z testu 100 pomyślnych walk z czarnymi pasami z rzędu, pokazów łamania drewna i bloków lodu gołymi rękami, a także z przechwycenia ostrza miecza samurajskiego gołymi rękami podczas ataku.",
                style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.6),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 24),

              // Nagłówek 2
              const Text(
                "Filozofia Walki",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Tekst na podstawie drugiej części
              const Text(
                "Styl OYAMA był rozwijany jako sztuka walki, samoobrona oraz w formule kontaktowej (full contact - z atakiem na głowę w rękawicach, a także knockdown i semi-knockdown - bez ataku na głowę ciosami). Shigeru Oyama odrzucił doktrynę walki z Goju-ryu i Kyokushin, wprowadzając szybkie zmiany pozycji, przewidywanie ruchów przeciwnika, schodzenie z linii ciosu i błyskawiczne kontrataki. Zmienił niektóre bloki, ciosy i formy, udoskonalił pracę nóg i położył ogromny nacisk na rotację ciała.",
                style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.6),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 24),

              // Nagłówek 3
              const Text(
                "Kata i Trening",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Tekst na podstawie trzeciej części
              const Text(
                "Nowe kihon kata Soshu stworzyły pomost między nauką podstaw a prawdziwą walką. Stanowią one reprezentatywny obraz narodzin nowego karate na przełomie XX i XXI wieku. Zaawansowani studenci i mistrzowie ćwiczą kata z użyciem broni (Bo, Tonfa, Sai). Co ważne, w OYAMA IKF istnieje własny, dostosowany do możliwości psychofizycznych system nauczania dzieci, młodzieży i dorosłych. Trening z dziećmi koncentruje się na praktycznych zaletach karate: dobrym zdrowiu, poczuciu bezpieczeństwa i systematycznym kształtowaniu charakteru.",
                style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.6),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 30),

              // Linia oddzielająca sekcję Federacji
              const Divider(color: Colors.white24, thickness: 1),
              const SizedBox(height: 30),

              // Nagłówek 4 - Federacja
              const Row(
                children: [
                  Icon(Icons.public, color: Colors.amber, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Międzynarodowa Federacja (OYAMA IKF)",
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Tekst na podstawie informacji o OYAMA IKF
              const Text(
                "Międzynarodowa Federacja Karate OYAMA (OYAMA IKF) to międzynarodowa organizacja non-profit zrzeszająca sportowe kluby karate. Jej głównym celem jest szerzenie idei karate Oyama i sportu, działanie na rzecz integracji i współpracy międzynarodowej, a także rozwój kontaktów między społeczeństwami i przeciwdziałanie patologiom społecznym.",
                style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.6),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              const Text(
                "Po tym, jak Soshu Shigeru Oyama zamknął Centralne Dojo w Nowym Jorku, organizacje z kilku krajów Europy (w tym z Polski) postanowiły działać samodzielnie na szczeblu międzynarodowym. Pod koniec 2004 roku zainicjowały one powstanie OYAMA IKF. Organizacja ta, pod przewodnictwem Hanshi Jana Dyducha, zyskała pełne zaufanie i poparcie Wielkiego Mistrza Shigeru Oyamy. Legendarny twórca zaakceptował jej cele i przekazał dyrektorowi pełne prawa do korzystania z jego imienia, nazwiska, stopnia, wizerunku oraz znaków towarowych.",
                style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.6),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 40), // Zapas miejsca na dole


            ],
          ),
        ),
      ),
    );
  }
}