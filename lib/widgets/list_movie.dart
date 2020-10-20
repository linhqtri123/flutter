import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/models/movie_model.dart';
import 'package:demo/movie_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

Widget listMovie(BuildContext context, MovieType type) {
  List<Movie> movies;
  switch (type) {
    case MovieType.nowPlaying:
      movies = context.watch<MovieViewModel>().getNowPlayingList();
      break;
    case MovieType.upcoming:
      movies = context.watch<MovieViewModel>().getUpcomingList();
      break;
    case MovieType.topRated:
      movies = context.watch<MovieViewModel>().getTopRatedList();
      break;
    case MovieType.popular:
      movies = context.watch<MovieViewModel>().getPopularList();
      break;
  }
  return Container(
    height: 250.0,
    padding: EdgeInsets.only(left: 5.0),
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: movies[index]);
          },
          child: Container(
            height: 220.0,
            padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      imageUrl: '$imageUrl${movies[index].posterPath}',
                      placeholder: (context, url) {
                        return Container(
                          height: 200.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            color: mDarkBlue2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: 120.0,
                  child: Text(
                    movies[index].title,
                    style: TextStyle(
                      color: mLightGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.stars,
                      color: mAccentColor,
                      size: 13.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${movies[index].voteAverage}',
                      style: TextStyle(
                        color: mLightGrey,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: movies.length,
    ),
  );
}
