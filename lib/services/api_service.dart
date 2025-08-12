import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters() async {
    List<Character> allCharacters = [];
    String? nextPageUrl = '$_baseUrl/character';

    while (nextPageUrl != null) {
      final response = await http.get(Uri.parse(nextPageUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> results = data['results'];
        allCharacters.addAll(
          results.map((json) => Character.fromJson(json)).toList(),
        );

        nextPageUrl = data['info']['next'];
      } else {
        throw Exception('Falha ao carregar os personagens');
      }
    }

    return allCharacters;
  }

  Future<String> fetchEpisodeName(String episodeUrl) async {
    final response = await http.get(Uri.parse(episodeUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['name'];
    } else {
      throw Exception('Falha ao carregar o nome do episódio');
    }
  }
}
