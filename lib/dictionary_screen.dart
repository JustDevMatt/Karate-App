import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dictionary_data.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  // Domyślnie wybrana pierwsza kategoria (Liczebniki)
  DictCategory _selectedCategory = DictCategory.numbers;
  String _searchQuery = '';

  // 1. INTELIGENTNE FILTROWANIE: bez szukania -> tylko wybrana kategoria; z szukaniem -> wszystko (wybrana kategoria na górze)
  List<DictionaryItem> get _filteredItems {
    // 1. KROK: Gdy wyszukiwarka jest PUSTA -> pokazujemy tylko wybraną zakładkę
    if (_searchQuery.trim().isEmpty) {
      return oyamaDictionary
          .where((item) => item.category == _selectedCategory)
          .toList();
    }

    // 2. KROK: Gdy użytkownik COŚ WPISAŁ -> szukamy w CAŁEJ bazie (bez sprawdzania kategorii!)
    final query = _searchQuery.trim().toLowerCase();
    final matches = oyamaDictionary.where((item) {
      return item.japanese.toLowerCase().contains(query) ||
          item.polish.toLowerCase().contains(query);
    }).toList();

    // 3. KROK: Sortujemy wyniki -> słówka z obecnie klikniętej zakładki lądują na samej górze
    matches.sort((a, b) {
      final aIsSelected = a.category == _selectedCategory;
      final bIsSelected = b.category == _selectedCategory;
      if (aIsSelected && !bIsSelected) return -1;
      if (!aIsSelected && bIsSelected) return 1;
      return 0;
    });

    return matches;
  }

  // Funkcja otwierająca tryb fiszek z przefiltrowaną listą
  void _openFlashcards() {
    final itemsToStudy = _filteredItems;

    if (itemsToStudy.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Brak słówek w tej kategorii do nauki!')),
      );
      return;
    }

    // TODO: Nawigacja do Twojego ekranu z fiszkami, przekazując listę [itemsToStudy]
    debugPrint('Otwieram fiszki dla kategorii: ${_selectedCategory.label} (${itemsToStudy.length} słówek)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'SŁOWNIK TERMINÓW',
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(color: Colors.amber, letterSpacing: 1.5),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.amber),
      ),
      body: Column(
        children: [
          // --- 1. PASEK WYSZUKIWARKI ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Szukaj słówka (jp / pl)...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.amber),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // --- 2. PRZEŁĄCZNIK 4 KATEGORII (Wymagany wariant) ---
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: DictCategory.values.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      category.label,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Colors.amber,
                    backgroundColor: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.amber : Colors.white12,
                      ),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // --- 3. PRZYCISK: FISZKI DLA WYBRANEJ KATEGORII ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.style, size: 22),
                label: Text(
                  'FISZKI: ${_selectedCategory.label.toUpperCase()} (${_filteredItems.length})',
                  style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
                onPressed: _openFlashcards,
              ),
            ),
          ),

          const Divider(color: Colors.white12, height: 16),

          // --- 4. LISTA SŁÓWEK ---
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
              child: Text(
                'Brak słówek w tej kategorii / wynikach.',
                style: TextStyle(color: Colors.white38),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Słówko japońskie (Złote, pogrubione)
                      Expanded(
                        flex: 5,
                        child: Text(
                          item.japanese,
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                              color: Colors.amber,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      // 2. Tłumaczenie polskie + podpis kategorii przy wyszukiwaniu globalnym
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.polish,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            // Wyświetla mały podpis, gdy słówko jest z innej zakładki podczas wyszukiwania
                            if (_searchQuery.isNotEmpty && item.category != _selectedCategory)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  item.category.label,
                                  style: TextStyle(
                                    color: Colors.amber.withOpacity(0.7),
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
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