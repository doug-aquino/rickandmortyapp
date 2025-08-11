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

  @override
  void initState() {
    super.initState();
    _charactersFuture = _controller.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado.'));
          }

          final characters = snapshot.data!;

          
          const double cardHeight = 160.0;
         

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                runSpacing: 15, // Espaço vertical entre as linhas de cards
                alignment: WrapAlignment.center, // Centraliza os cards
                children: characters.map((character) {
                  // Cada card é envolvido por um SizedBox com o tamanho definido.
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
                              padding: const EdgeInsets.only(left: 16, top: 12, right: 203, bottom: 11),
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