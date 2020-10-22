import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/animation/fade_animation.dart';
import 'package:demo/constants.dart';
import 'package:demo/models/genre.dart';
import 'package:demo/models/movie_model.dart';
import 'package:flutter/material.dart';

class DetailMovie extends StatelessWidget {
  static const routeDetail = '/detail';
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mPrimaryColor,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _posterImage(movie, _size),
            _titleMovie(movie),
            SizedBox(
              height: 5.0,
            ),
            _genreMovie(movie),
            SizedBox(
              height: 8.0,
            ),
            _dateLanguage(movie),
            _overview(movie)
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryColor,
    );
  }

  Widget _posterImage(Movie movie, Size _size) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: _size.height * 0.45,
          width: _size.width * 0.57,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Hero(
                tag: movie.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterPath != null
                        ? '$imageUrl${movie.posterPath}'
                        : imageBlueUrl,
                    height: _size.height * 0.42,
                    width: _size.width * 0.47,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: _size.height * 0.005,
                right: _size.width * 0.03,
                child: Container(
                  height: _size.height * 0.05,
                  width: _size.width * 0.09,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      movie.voteAverage.toString(),
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleMovie(Movie movie) {
    return FadeAnimation(
      1.3,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(
          movie.title,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 25.0,
            fontWeight: FontWeight.w900,
            color: mLightGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _genreMovie(Movie movie) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            for (Genre genre in movie.genreIds)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                child: Chip(
                  label: Text(
                    genre.name,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: mPrimaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dateLanguage(Movie movie) {
    return FadeAnimation(
      1.3,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            movie.releaseDate[0],
            style: TextStyle(
              color: mLightGrey,
            ),
          ),
          Text(
            movie.releaseDate[1],
            style: TextStyle(
              color: mLightGrey,
            ),
          ),
          Text(
            movie.releaseDate[2],
            style: TextStyle(
              color: mLightGrey,
            ),
          ),
          Text(
            movie.releaseDate[3],
            style: TextStyle(
              color: mLightGrey,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Container(
            height: 5.0,
            width: 5.0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          SizedBox(width: 5.0),
          Text(
            movie.originalLanguage.toUpperCase(),
            style: TextStyle(
              color: mLightGrey,
            ),
          )
        ],
      ),
    );
  }

  Widget _overview(Movie movie) {
    return FadeAnimation(
      1.3,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Synopsis',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: mLightGrey,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              movie.overview,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: mLightGrey,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
