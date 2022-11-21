import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/film_model.dart';

class FilmsProvider {
  String _apiKey = 'a1aac668c65b1eb3068041ef8a5c5a79';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {"api_key": _apiKey, "language": _language});
    // Await the http get response, then decode the json-formatted response.
    return await _filmsFromResponse(url);
  }

  Future<List<Film>> getMostPopular() async {
    final url = Uri.https(
        _url, '3/movie/popular', {"api_key": _apiKey, "language": _language});
    // Await the http get response, then decode the json-formatted response.
    return await _filmsFromResponse(url);
  }

  Future<List<Film>> _filmsFromResponse(Uri url) async{
    var response = await http.get(url);
    var decodedData = convert.json.decode(response.body);
    var films = Films.fromJsonList(decodedData['results']);
    return films.items;
  }
}
