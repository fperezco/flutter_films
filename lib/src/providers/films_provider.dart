import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/film_model.dart';

class FilmsProvider {
  String _apiKey = 'a1aac668c65b1eb3068041ef8a5c5a79';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularMoviesPage = 0;
  bool requestingNewPopularMoviesSet = false;

  //to work with the stream
  List<Film> _popularFilms = [];
  //broadcast for more than one listener
  final _popularFilmsStreamController =
      StreamController<List<Film>>.broadcast();

  //Just a way to envelope the methods of the stream inside this class
  //define a function that invoke the sink ,add films into the stream
  Function(List<Film>) get popularFilmsSink =>
      _popularFilmsStreamController.sink.add;

  //listen the new films in the stream
  Stream<List<Film>> get popularFilmsStream =>
      _popularFilmsStreamController.stream;

  void dispose() {
    //we should close the stream when we go out this widget
    _popularFilmsStreamController?.close();
  }

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {"api_key": _apiKey, "language": _language});
    // Await the http get response, then decode the json-formatted response.
    return await _filmsFromResponse(url);
  }

  Future<List<Film>> getMostPopular() async {
    if (requestingNewPopularMoviesSet) return [];
    //to prevent do simultaneous calls
    requestingNewPopularMoviesSet = true;
    _popularMoviesPage++;
    print("loading next: $_popularMoviesPage");
    final url = Uri.https(_url, '3/movie/popular', {
      "api_key": _apiKey,
      "language": _language,
      "page": _popularMoviesPage.toString()
    });
    // Await the http get response, then decode the json-formatted response.
    var filmsList = await _filmsFromResponse(url);
    _popularFilms.addAll(filmsList); //add list to list
    //introduce into the stream, it will trigger an action in all the listeners
    popularFilmsSink(_popularFilms);
    requestingNewPopularMoviesSet = false;
    return filmsList;
  }

  Future<List<Film>> _filmsFromResponse(Uri url) async {
    var response = await http.get(url);
    var decodedData = convert.json.decode(response.body);
    var films = Films.fromJsonList(decodedData['results']);
    return films.items;
  }
}
