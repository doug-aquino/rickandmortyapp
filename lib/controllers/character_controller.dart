
import 'package:rickandmortyapp/models/character.dart';
import 'package:rickandmortyapp/services/api_service.dart';

class CharacterController {
  final ApiService _apiService = ApiService();

  Future<List<Character>> fetchCharacters() {
    return _apiService.fetchCharacters();
  }

  Future<String> fetchEpisodeName(String episodeUrl) {
    return _apiService.fetchEpisodeName(episodeUrl);
  }
}