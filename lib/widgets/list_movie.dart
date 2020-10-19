import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

Widget listMovie(BuildContext context, String title) {
  List<Movie> movies;
  switch (title) {
    case 'Now Playing':
      movies = context.watch<MovieViewModel>().getNowPlayingList();
      break;
    case 'Popular':
      movies = context.watch<MovieViewModel>().getPopularList();
      break;
    case 'Up Coming':
      movies = context.watch<MovieViewModel>().getUpcomingList();
      break;
    default:
      movies = context.watch<MovieViewModel>().getTopRatedList();
      break;
  }
  return Container(
    height: 250.0,
    padding: EdgeInsets.only(left: 5.0),
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
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
                      imageUrl: '$imageUrl${movies[index].poster_path}',
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
                      '${movies[index].vote_average}',
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
