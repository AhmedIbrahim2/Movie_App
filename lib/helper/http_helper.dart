import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';

class HttpHelper {
  static Future<List<Movie>> getUpcoming() async {
    const String upcoming =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=2699115b03930e90a8fce543668a7a4c&language=en-US';

    var response = await http.get(Uri.parse(upcoming));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(response.body);
      final moviesMap = jsonResponse['results'];
      List<Movie> movies =
          List<Movie>.from(moviesMap.map((e) => Movie.fromJson(e)));
      return movies;
    } else {
      return [];
    }
  }

  static Future<List<Movie>> findMovies(String title) async {
    const String urlSearchBase =
        'https://api.themoviedb.org/3/search/movie?api_key=2699115b03930e90a8fce543668a7a4c&query=';
    final String query = urlSearchBase + title;
    final result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(result.body);
      final moviesMap = jsonResponse['results'];
      List<Movie> movies =
          List<Movie>.from(moviesMap.map((i) => Movie.fromJson(i)));
      return movies;
    } else {
      return [];
    }
  }
}
