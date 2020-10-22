import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/models/movie_model.dart';
import 'package:demo/resources/movies_api.dart';
import 'package:demo/widgets/search_place_holder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Search extends StatelessWidget {
  static const routeSearch = '/search';
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mPrimaryColor,
      appBar: buildSearchBar(context),
      body: buildSearchResults(context),
    );
  }

  AppBar buildSearchBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black12,
      automaticallyImplyLeading: false,
      title: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        onChanged: (query) {
          if (query.isNotEmpty) {
            context
                .read<MovieViewModel>()
                .fetchFutureSarch(MovieApi().fetchSearchMovie(query));
          }
        },
        autofocus: true,
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Search Movie',
          hintStyle: TextStyle(
            color: mLightGrey,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 28.0,
          ),
          suffix: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () => clearSearch(context),
          ),
        ),
      ),
    );
  }

  Consumer<MovieViewModel> buildSearchResults(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FutureBuilder<List<Movie>>(
            future: value.getFutureSearch(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return searchPlaceholder();
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      openDetailsScreen(context, snapshot.data[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              buildPoster(snapshot.data, index),
                              buildDetails(snapshot.data, index),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Container buildPoster(List<Movie> snapshot, int index) {
    return Container(
      height: 150.0,
      width: 100.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: CachedNetworkImage(
          imageUrl: snapshot[index].posterPath != null
              ? '$imageUrl${snapshot[index].posterPath}'
              : imageBlueUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildDetails(List<Movie> snapshot, int index) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 160,
                child: Text(
                  snapshot[index].title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                ' (${snapshot[index].releaseDate.toString().substring(0, 4)})',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.stars,
                color: mAccentColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${snapshot[index].voteAverage}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openDetailsScreen(BuildContext context, Movie movie) {
    Navigator.pushNamed(context, '/detail', arguments: movie);
  }

  void clearSearch(BuildContext context) {
    searchController.clear();
    Navigator.pop(context);
  }
}
