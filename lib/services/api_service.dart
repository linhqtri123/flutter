import 'dart:convert';
import 'package:demo/models/movie_model.dart';
import 'package:demo/resources/custom_exception.dart';
import 'package:http/http.dart';

class ApiService {
  Future<List<Movie>> apiService(Response response) async {
    return _response(response);
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        final jsonBody = json.decode(response.body);
        return (jsonBody['results'] as List)
            .map((m) => Movie.fromJson(m))
            .toList();
      case 400:
        throw BadRequestException(json.decode(response.body)['status_message']);
      case 401:

      case 403:
        throw UnauthorisedException(
            json.decode(response.body)['status_message']);
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
