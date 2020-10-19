import 'package:flutter/material.dart';

class Movie {
  int id;
  int vote_count;
  var vote_average;
  String title;
  String release_date;
  String original_language;
  String original_title;
  List<dynamic> genre_ids;
  String backdrop_path;
  String overview;
  String poster_path;
  double popularity;
  bool video;
  bool adult;

  // Named Constructor
  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    vote_count = parsedJson['vote_count'];
    vote_average = parsedJson['vote_average'];
    title = parsedJson['title'];
    release_date = parsedJson['release_date'];
    original_language = parsedJson['original_language'];
    original_title = parsedJson['original_title'];
    genre_ids = parsedJson['genre_ids'];
    backdrop_path = parsedJson['backdrop_path'];
    overview = parsedJson['overview'];
    poster_path = parsedJson['poster_path'];
    popularity = parsedJson['popularity'];
    video = parsedJson['video'];
    adult = parsedJson['adult'];
  }
}

class MovieViewModel with ChangeNotifier {
  List<Movie> nowPlayingList = [];
  List<Movie> popularList = [];
  List<Movie> upcomingList = [];
  List<Movie> topRatedList = [];
  Future<List<Movie>> futureSearch;

  void fetchNowPlayingMovies(List<Movie> movies) {
    nowPlayingList = movies;
  }

  void fetchPopularMovies(List<Movie> movies) {
    popularList = movies;
  }

  void fetchUpcomingMovies(List<Movie> movies) {
    upcomingList = movies;
  }

  void fetchtopRatedMovies(List<Movie> movies) {
    topRatedList = movies;
  }

  void fetchFutureSarch(Future<List<Movie>> future) {
    futureSearch = future;
    notifyListeners();
  }

  List<Movie> getNowPlayingList() => nowPlayingList;

  List<Movie> getPopularList() => popularList;

  List<Movie> getUpcomingList() => upcomingList;

  List<Movie> getTopRatedList() => topRatedList;

  Future<List<Movie>> getFutureSearch() => futureSearch;
}
