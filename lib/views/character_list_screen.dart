import 'package:flutter/material.dart';
import 'package:rickandmortyapp/controllers/character_controller.dart';
import 'package:rickandmortyapp/models/character.dart';
import 'package:rickandmortyapp/views/app_bar_widgets.dart';
import 'package:rickandmortyapp/views/character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final CharacterController _controller = CharacterController();
  late Future<List<Character>> _charactersFuture;
  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _charactersFuture = _controller.fetchCharacters();
    _charactersFuture.then((characters) {
      setState(() {
        _allCharacters = characters;
        _filteredCharacters = characters;
      });
    });
  }

  void _filterCharacters(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredCharacters = _allCharacters;
      } else {
        _filteredCharacters = _allCharacters
            .where((character) =>
                character.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(
        leftIcon: const Icon(Icons.menu, color: Colors.white),
        onSearchChanged: _filterCharacters,
      ),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _allCharacters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (_filteredCharacters.isEmpty && _searchQuery.isNotEmpty) {
            return const Center(
                child: Text('Nenhum personagem encontrado com esse nome.'));
          } else if (_allCharacters.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado.'));
          }

          final characters = _filteredCharacters;

          const double cardHeight = 160.0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: characters.map((character) {
                  return SizedBox(
                    height: cardHeight,
                    child: Card(
                      color: const Color(0xFF87A1FA),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CharacterDetailScreen(character: character),
                            ),

                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                character.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 12,
                                right: 16, // Ajuste para evitar overflow
                                bottom: 11,
                              ),
                              child: Text(
                                character.name,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
