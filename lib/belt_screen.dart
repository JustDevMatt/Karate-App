import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_dictionary.dart';
import 'karate_data.dart';      // Importujemy naszą bazę danych
import 'realistic_belt.dart';   // Importujemy nasz graficzny pas
import 'kata_detail_screen.dart';

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
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildKataSection(); // Zmieniamy z Text() na nową funkcję
      case 1:
        return _buildRequirementsSection(); // Nasz nowy, potężny system pasów!
      case 2:
        return Center(child: Text(AppDictionary.techSection(widget.styleName), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 18)));
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
                // Tu w przyszłości dodamy przejście do ekranu z nagraniami konkretnych wymagań
                print("Kliknięto szczegóły dla: ${rank.name}");
              },
            );
          }).toList(),
        );
      },
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
            ListTile(
              leading: const Icon(Icons.home, color: Colors.amber),
              title: Text(AppDictionary.home, style: const TextStyle(color: Colors.white, fontSize: 16)),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Colors.amber),
              title: Text(AppDictionary.clubHistory, style: const TextStyle(color: Colors.white, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.smart_display, color: Colors.redAccent),
              title: Text(AppDictionary.news, style: const TextStyle(color: Colors.white, fontSize: 16)),
              subtitle: Text(AppDictionary.newsSubtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.local_cafe, color: Colors.amber),
              title: Text(AppDictionary.support, style: const TextStyle(color: Colors.white, fontSize: 16)),
              subtitle: Text(AppDictionary.supportSubtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () {
                Navigator.pop(context);
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