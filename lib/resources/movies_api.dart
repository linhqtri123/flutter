import 'package:demo/models/movie_model.dart';
import 'package:demo/services/api_service.dart';
import 'package:http/http.dart';
import '../constants.dart';

class MovieApi {
  final apiService = ApiService();
  Future<List<Movie>> fetchNowPlayingMovies() async {
    final response = await get(nowPlayingApi);
    return apiService.apiService(response);
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await get(popularApi);
    return apiService.apiService(response);
  }

  Future<List<Movie>> fetchTopRatedMoives() async {
    final response = await get(topRatedApi);
    return apiService.apiService(response);
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await get(upcomingApi);
    return apiService.apiService(response);
  }

  Future<List<Movie>> fetchSearchMovie(String query) async {
    final response = await get('$search$query');
    return apiService.apiService(response);
  }
}
