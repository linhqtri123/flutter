import 'dart:convert';
import 'package:demo/models/movie_model.dart';
import 'package:http/http.dart';
import '../constants.dart';

class MovieApi {
  Future<List<Movie>> fetchNowPlayingMovies() async {
    final response = await get('$nowPlayingApi');
    final jsonBody = json.decode(response.body);
    return (jsonBody['results'] as List).map((m) => Movie.fromJson(m)).toList();
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await get('$popularApi');
    final jsonBody = json.decode(response.body);
    return (jsonBody['results'] as List).map((m) => Movie.fromJson(m)).toList();
  }

  Future<List<Movie>> fetchTopRatedMoives() async {
    final response = await get('$topRatedApi');
    final jsonBody = json.decode(response.body);
    return (jsonBody['results'] as List).map((m) => Movie.fromJson(m)).toList();
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await get('$upcomingApi');
    final jsonBody = json.decode(response.body);
    return (jsonBody['results'] as List).map((m) => Movie.fromJson(m)).toList();
  }

  Future<List<Movie>> fetchSearchMovie(String query) async {
    final response = await get('$search$query');
    final jsonBody = json.decode(response.body);
    return (jsonBody['results'] as List).map((m) => Movie.fromJson(m)).toList();
  }
}
