class Genre {
  int id;
  String name;

  Genre({this.id, this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  @override
  String toString() => name;
}

final List<Genre> genres = [
  {'id': 10759, 'name': 'Action & Adventure'},
  {'id': 28, 'name': 'Action'},
  {'id': 10763, 'name': 'News'},
  {'id': 12, 'name': 'Adventure'},
  {'id': 10764, 'name': 'Reality'},
  {'id': 16, 'name': 'Animation'},
  {'id': 10765, 'name': 'Sci-Fi & Fantasy'},
  {'id': 35, 'name': 'Comedy'},
  {'id': 10766, 'name': 'Soap'},
  {'id': 80, 'name': 'Crime'},
  {'id': 10767, 'name': 'Talk'},
  {'id': 10768, 'name': 'War & Politics'},
  {'id': 99, 'name': 'Documentary'},
  {'id': 18, 'name': 'Drama'},
  {'id': 10751, 'name': 'Family'},
  {'id': 10762, 'name': 'Kids'},
  {'id': 14, 'name': 'Fantasy'},
  {'id': 36, 'name': 'History'},
  {'id': 27, 'name': 'Horror'},
  {'id': 10402, 'name': 'Music'},
  {'id': 9648, 'name': 'Mystery'},
  {'id': 10749, 'name': 'Romance'},
  {'id': 878, 'name': 'Science Fiction'},
  {'id': 10770, 'name': 'TV Movie'},
  {'id': 53, 'name': 'Thriller'},
  {'id': 10752, 'name': 'War'},
  {'id': 37, 'name': 'Western'}
].map((genreMap) => Genre.fromJson(genreMap)).toList();

List<Genre> genresTM(List<dynamic> genreIds) {
  List<Genre> result;
  result = [];
  genreIds.forEach((genreId) {
    result.add(genres.firstWhere((genre) => genre.id == genreId));
  });
  return result;
}
