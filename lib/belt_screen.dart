import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_dictionary.dart';
import 'karate_data.dart';      // Importujemy naszą bazę danych
import 'realistic_belt.dart';   // Importujemy nasz graficzny pas
import 'kata_detail_screen.dart';
import 'belt_detail_screen.dart';
import 'history_screen.dart';
import 'package:url_launcher/url_launcher.dart'; //Do linków poza aplikację
import 'calendar_screen.dart';

class BeltScreen extends StatefulWidget {
  final String styleName;

  const BeltScreen({super.key, required this.styleName});

  @override
  State<BeltScreen> createState() => _BeltScreenState();
}

class _BeltScreenState extends State<BeltScreen> {
  int _selectedIndex = 1; // Zaczynamy od Wymagań

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Ta funkcja decyduje, co wyświetlić na środku ekranu
  // Ta funkcja decyduje, co wyświetlić na środku ekranu
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildKataSection();
      case 1:
        return _buildRequirementsSection();
      case 2:
        return _buildTechniquesSection(); // <--- Zmiana tutaj! Ładujemy naszą nową sekcję
      case 3:
        return Center(child: Text(AppDictionary.flashSection(widget.styleName), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 18)));
      default:
        return const SizedBox.shrink();
    }
  }

  // ==============================================================
  // Budowa sekcji KATA
  // ==============================================================
  Widget _buildKataSection() {
    // Sprawdzamy, czy wybrano Oyama Karate
    bool isOyama = widget.styleName == AppDictionary.oyamaKarate;
    // Jeśli tak, ładujemy układy Oyama. Jeśli nie, ładujemy Kyokushin!
    List<KataCategory> kataCategories = isOyama ? KarateData.oyamaKatas : KarateData.kyokushinKatas;

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: kataCategories.length,
      itemBuilder: (context, index) {
        final category = kataCategories[index];

        return Card(
          color: const Color(0xFF1E1E1E), // Ciemne, eleganckie tło kafelka
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ExpansionTile(
            collapsedIconColor: Colors.amber,
            iconColor: Colors.amber,
            title: Text(
              category.title,
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.0,
              ),
            ),
            children: category.katas.map((kata) {
              return ListTile(
                // Ikonka odtwarzacza wideo, sugerująca, że w przyszłości będą tu filmiki
                leading: const Icon(Icons.play_circle_outline, color: Colors.white54, size: 30),
                title: Text(
                    kata.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
                ),
                // Jeśli dodaliśmy opis (np. "Broń: Tonfa"), to się wyświetli
                subtitle: kata.description != null
                    ? Text(kata.description!, style: const TextStyle(color: Colors.grey, fontSize: 12))
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KataDetailScreen(kata: kata),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // ==============================================================
  // GŁÓWNA LOGIKA: Budowa ekranu Wymagań (Zakładki + Akordeon)
  // ==============================================================
  Widget _buildRequirementsSection() {
    // 1. Sprawdzamy, jaki styl wybrano i ładujemy odpowiednie listy z bazy
    bool isOyama = widget.styleName == AppDictionary.oyamaKarate;

    List<BeltGroup> juniorBelts = isOyama ? KarateData.oyamaJuniorBelts : KarateData.kyokushinJuniorBelts;
    List<BeltGroup> seniorBelts = isOyama ? KarateData.oyamaSeniorBelts : KarateData.kyokushinSeniorBelts;

    // 2. DefaultTabController obsługuje przełączanie między zakładkami na górze
    return DefaultTabController(
      length: 2, // Mamy dwie zakładki (Junior i Senior)
      child: Column(
        children: [
          // Pasek zakładek
          TabBar(
            indicatorColor: Colors.amber, // Kolor paska podkreślającego
            labelColor: Colors.amber,     // Kolor aktywnego tekstu
            unselectedLabelColor: Colors.grey, // Kolor nieaktywnego tekstu
            tabs: [
              Tab(text: AppDictionary.under14),
              Tab(text: AppDictionary.adults),
            ],
          ),
          // Zawartość zakładek
          Expanded(
            child: TabBarView(
              children: [
                _buildBeltList(juniorBelts), // Ładuje harmonijkę dla dzieci
                _buildBeltList(seniorBelts), // Ładuje harmonijkę dla dorosłych
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Funkcja budująca rozwijaną listę (Akordeon)
  Widget _buildBeltList(List<BeltGroup> beltGroups) {
    return ListView.builder(
      itemCount: beltGroups.length,
      itemBuilder: (context, index) {
        final group = beltGroups[index];

        // ExpansionTile to ten klikalny kafelek, który rozwija się w dół
        return ExpansionTile(
          collapsedIconColor: Colors.white54,
          iconColor: Colors.amber, // Strzałka po rozwinięciu
          // Tytuł kafelka - np. "BIAŁY PAS" - używamy koloru pasa do tekstu
          title: Text(
            group.colorName,
            style: TextStyle(
              color: group.beltColor == Colors.white ? Colors.white : group.beltColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          // Tutaj wklejamy stopnie po rozwinięciu kafelka
          children: group.ranks.map((rank) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              // Z lewej strony ładujemy nasz wirtualnie rysowany pas!
              leading: RealisticBelt(
                beltColor: group.beltColor,
                redStripes: rank.redStripes,
                mainStripe: rank.mainStripe,
              ),
              // Z prawej strony tekst stopnia
              title: Text(
                rank.name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                rank.description,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              onTap: () {
                // Sprawdzamy, w jakim jesteśmy stylu
                bool isOyama = widget.styleName == AppDictionary.oyamaKarate;

                if (isOyama) {
                  // LOGIKA DLA OYAMA (Szukamy w bazie)
                  Belt? selectedBelt;
                  try {
                    selectedBelt = KarateData.oyamaAdultBelts.firstWhere(
                          (b) => b.name.contains(rank.name),
                    );
                  } catch (e) {
                    selectedBelt = null;
                  }

                  if (selectedBelt != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeltDetailScreen(belt: selectedBelt!),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Wymagania dla tego stopnia nie zostały jeszcze dodane.'),
                        backgroundColor: Colors.grey,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  // LOGIKA DLA KYOKUSHIN (Zablokowana na czas tworzenia Oyama)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Szczegółowe wymagania Kyokushin pojawią się w kolejnej aktualizacji!'),
                      backgroundColor: Colors.blueGrey,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  // ==========================================================
  // WYSUWANY PANEL DLA TECHNIKI (Identyczny jak w Wymaganiach)
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
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, MediaQuery.of(context).padding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50, height: 5,
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 25),
              Text(title, style: const TextStyle(color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(translation, style: const TextStyle(color: Colors.white54, fontSize: 16, fontStyle: FontStyle.italic)),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200, color: Colors.black45,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, color: Colors.white24, size: 50),
                          SizedBox(height: 10),
                          Text('Brak obrazka', style: TextStyle(color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(description, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5)),
            ],
          ),
        );
      },
    );
  }

  // ==============================================================
  // BUDOWA SEKCJI TECHNIKI (Zakładki przewijane na boki + Kafelki)
  // ==============================================================
  Widget _buildTechniquesSection() {
    // Pobieramy naszą nową bazę technik z karate_data.dart
    List<TechniqueCategory> categories = KarateData.oyamaTechniques;

    return DefaultTabController(
      length: categories.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pasek zakładek (scrollowany)
          TabBar(
            isScrollable: true, // To sprawia, że można je przesuwać palcem w prawo/lewo!
            tabAlignment: TabAlignment.start, // Wyrównanie do lewej strony
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            tabs: categories.map((cat) => Tab(text: cat.title.toUpperCase())).toList(),
          ),
          // Listy kafelków dla każdej zakładki
          Expanded(
            child: TabBarView(
              children: categories.map((cat) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: cat.techniques.length,
                  itemBuilder: (context, index) {
                    final tech = cat.techniques[index];
                    return Card(
                      color: const Color(0xFF1E1E1E),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 12.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _showTechniqueBottomSheet(
                          context,
                          title: tech.name,
                          translation: tech.translation,
                          description: tech.description,
                          imagePath: tech.imagePath,
                        ),
                        child: Row(
                          children: [
                            // ZDJĘCIE PO LEWEJ
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                              child: Container(
                                color: Colors.white, // Białe tło dla starych rycin
                                child: Image.asset(
                                  tech.imagePath,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain, // Nie obcina rysunku, dopasowuje go do kwadratu
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 100, height: 100, color: Colors.black45,
                                    child: const Icon(Icons.image_not_supported, color: Colors.white24),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // TEKSTY PO PRAWEJ
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tech.name,
                                      style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tech.translation,
                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Kliknij po szczegóły >",
                                      style: TextStyle(color: Colors.white30, fontSize: 12, fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.styleName,
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
        elevation: 0,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),

      // ... (Drawer pozostaje bez zmian, używa AppDictionary z poprzedniego kroku)
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Icon(Icons.sports_martial_arts, color: Colors.amber, size: 60),
            ),
            // Wybór stylu karate
            ListTile(
              leading: const Icon(Icons.home, color: Colors.amber),
              title: Text(AppDictionary.home, style: const TextStyle(color: Colors.white, fontSize: 16)),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            // Historia Stylu
            ListTile(
              leading: const Icon(Icons.book, color: Colors.amber),
              title: Text(AppDictionary.styleHistory, style: const TextStyle(color: Colors.white, fontSize: 16)),
              onTap: () {
                // Zamykamy najpierw boczne menu
                Navigator.pop(context);
                // Przechodzimy do nowego ekranu historii
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
              },
            ),
            if (AppDictionary.isPolish) ...[ // Te '...' oznaczają "rozpakuj te elementy i wrzuć je tutaj, jeśli warunek jest spełniony"
              // Ten kafelek wyświetli się TYLKO jeśli isPolish to prawda
              ListTile(
                leading: const Icon(Icons.calendar_month, color: Colors.amber),
                title: const Text('Kalendarz PFK 2026', style: TextStyle(color: Colors.white, fontSize: 16)),
                subtitle: const Text('Zawody, seminaria i sesje', style: TextStyle(color: Colors.grey, fontSize: 12)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalendarScreen()),
                  );
                },
              ),
            ],
            // Okiem sportowca
            ListTile(
              leading: const Icon(Icons.smart_display, color: Colors.redAccent),
              title: Text(AppDictionary.news, style: const TextStyle(color: Colors.white, fontSize: 16)),
              subtitle: Text(AppDictionary.newsSubtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () {
                Navigator.pop(context);
                // TODO: jak się zgodzi twórca, to dodam działający link. Na ten moment ten kafelek będzie widoczny, ale nie funkcjonalny.
              },
            ),
            // Postaw mi kawę
            const Divider(color: Colors.white24), // Linia oddzielająca
            ListTile(
              leading: const Icon(Icons.local_cafe, color: Colors.amber),
              title: Text(AppDictionary.support, style: const TextStyle(color: Colors.white, fontSize: 16)),
              subtitle: Text(AppDictionary.supportSubtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () async {
                Navigator.pop(context);

                final Uri url = Uri.parse('https://buymeacoffee.com/justdevmatt');
                // Od razu wymuszamy otwarcie zewnątrz. System sam zdecyduje (Aplikacja czy Przeglądarka)
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  debugPrint('Nie udało się otworzyć linku: $url');
                }
              },
            ),
            // Twitter, czy tam 'X'
            const Divider(color: Colors.white24, thickness: 1), // Linia oddzielająca (opcjonalna, dla zachowania porządku) - nie mogę się zdecydować, czy zostawić ją czy nie
            ListTile(
              leading: const Icon(Icons.rocket_launch, color: Colors.amber),
              title: Text(AppDictionary.developerProfile, style: const TextStyle(color: Colors.white, fontSize: 16)),
              subtitle: Text(AppDictionary.developerProfileSubtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () async {
                Navigator.pop(context);

                final Uri url = Uri.parse('https://x.com/JustDevMatt');
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  debugPrint('Nie udało się otworzyć linku: $url');
                }
              },
            ),
          ],
        ),
      ),

      body: _buildBody(), // Używamy naszej nowej funkcji do budowania środka

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.accessibility_new),
            label: AppDictionary.katas,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            label: AppDictionary.requirements,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.back_hand),
            label: AppDictionary.techniques,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.style),
            label: AppDictionary.flashcards,
          ),
        ],
      ),
    );
  }
}