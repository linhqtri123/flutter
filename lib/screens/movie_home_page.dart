import 'package:demo/models/movie_model.dart';
import 'package:demo/movie_type.dart';
import 'package:demo/resources/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../resources/movies_api.dart';
import '../widgets/list_movie.dart';

class MovieHomePage extends StatefulWidget {
  static const routeHome = '/home';
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  Future<List<Movie>> futureNowPlayingMovie;
  Future<List<Movie>> futurePopularMovie;
  Future<List<Movie>> futureUpcomingMovie;
  Future<List<Movie>> futureTopRatedMovie;
  final movieApi = MovieApi();

  @override
  void initState() {
    super.initState();
    futureNowPlayingMovie = movieApi.fetchNowPlayingMovies();
    futurePopularMovie = movieApi.fetchPopularMovies();
    futureUpcomingMovie = movieApi.fetchUpcomingMovies();
    futureTopRatedMovie = movieApi.fetchTopRatedMoives();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: mPrimaryColor,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              _heading(
                title: 'Now Playing',
              ),
              SizedBox(height: 10.0),
              _getNowPlayingListMovie(),
              SizedBox(height: 15.0),
              _heading(
                title: 'Popular',
              ),
              SizedBox(height: 10.0),
              _getPopularMovie(),
              SizedBox(height: 20.0),
              _heading(
                title: 'Up Coming',
              ),
              SizedBox(height: 10.0),
              _getUpcomingMovie(),
              SizedBox(height: 20.0),
              _heading(
                title: 'Top Rated',
              ),
              SizedBox(height: 10.0),
              _getTopRatedListMovie(),
              SizedBox(height: 15.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        title: Text(
          'MovieTime',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: mAccentColor,
            letterSpacing: 1.4,
          ),
        ),
        backgroundColor: mPrimaryColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                context.read<MovieViewModel>().fetchFutureSarch(null);
                Navigator.pushNamed(context, '/search');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading({
    @required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 10.0,
        top: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: mLightGrey,
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'See all',
              style: TextStyle(
                color: mAccentColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getNowPlayingListMovie() {
    return FutureBuilder<List<Movie>>(
      future: futureNowPlayingMovie,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          context.watch<MovieViewModel>().fetchNowPlayingMovies(snapShot.data);
          return listMovie(context, MovieType.nowPlaying);
        } else if (snapShot.hasError) {
          return Center(
            child: Text(
              (snapShot.error as CustomException).convertToString(),
              style: TextStyle(color: mLightGrey, fontSize: 12),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _getPopularMovie() {
    return FutureBuilder<List<Movie>>(
      future: futurePopularMovie,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          context.watch<MovieViewModel>().fetchPopularMovies(snapShot.data);
          return listMovie(context, MovieType.popular);
        } else if (snapShot.hasError) {
          return Center(
            child: Text(
              (snapShot.error as CustomException).convertToString(),
              style: TextStyle(color: mLightGrey, fontSize: 12),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _getUpcomingMovie() {
    return FutureBuilder<List<Movie>>(
      future: futureUpcomingMovie,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          context.watch<MovieViewModel>().fetchUpcomingMovies(snapShot.data);
          return listMovie(context, MovieType.upcoming);
        } else if (snapShot.hasError) {
          return Center(
            child: Text(
              (snapShot.error as CustomException).convertToString(),
              style: TextStyle(color: mLightGrey, fontSize: 12),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _getTopRatedListMovie() {
    return FutureBuilder<List<Movie>>(
      future: futureTopRatedMovie,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          context.watch<MovieViewModel>().fetchtopRatedMovies(snapShot.data);
          return listMovie(context, MovieType.topRated);
        } else if (snapShot.hasError) {
          return Center(
            child: Text(
              (snapShot.error as CustomException).convertToString(),
              style: TextStyle(color: mLightGrey, fontSize: 12),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
