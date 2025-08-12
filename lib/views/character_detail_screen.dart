import 'package:flutter/material.dart';
import 'package:rickandmortyapp/controllers/character_controller.dart';
import 'package:rickandmortyapp/models/character.dart';
import 'package:rickandmortyapp/views/app_bar_widgets.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  final CharacterController _controller = CharacterController();

  CharacterDetailScreen({super.key, required this.character});

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(
        leftIcon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: const Color(0xFF87A1FA),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        character.image,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const Divider(color: Colors.white, height: 12.5),
                          _buildInfoRow('Status', character.status),
                          _buildInfoRow('Espécie', character.species),
                          _buildInfoRow('Gênero', character.gender),
                          _buildInfoRow('Origem', character.origin.name),
                          _buildInfoRow(
                            'Última localização',
                            character.location.name,
                          ),
                          FutureBuilder<String>(
                            future: _controller.fetchEpisodeName(
                              character.episode.first,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildInfoRow(
                                  'Primeira aparição',
                                  'Carregando...',
                                );
                              } else if (snapshot.hasError) {
                                return _buildInfoRow(
                                  'Primeira aparição',
                                  'Não disponível',
                                );
                              } else {
                                return _buildInfoRow(
                                  'Primeira aparição',
                                  snapshot.data ?? 'Não disponível',
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
