import 'package:demo/models/genre.dart';
import 'package:flutter/material.dart';

class Movie {
  int id;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<Genre> genreIds;
  String backdropPath;
  String overview;
  String posterPath;
  double popularity;
  bool video;
  bool adult;

  // Named Constructor
  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    voteCount = parsedJson['vote_count'];
    voteAverage = voteAverageTM(parsedJson['vote_average']);
    title = parsedJson['title'];
    releaseDate = parsedJson['release_date'];
    originalLanguage = parsedJson['original_language'];
    originalTitle = parsedJson['original_title'];
    genreIds = genresTM(parsedJson['genre_ids']);
    backdropPath = parsedJson['backdrop_path'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
    popularity = parsedJson['popularity'];
    video = parsedJson['video'];
    adult = parsedJson['adult'];
  }

  double voteAverageTM(dynamic voteAverage) {
    return voteAverage + .0;
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
