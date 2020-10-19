import 'package:demo/models/movie_model.dart';
import 'package:demo/resources/movies_api.dart';
import 'package:demo/widgets/search_place_holder.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        onChanged: (String query) {
          if (query != "") {
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

  buildSearchResults(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FutureBuilder<List<Movie>>(
            future: value.getFutureSearch(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return searchPlaceholder();
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
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
          imageUrl: snapshot[index].poster_path != null
              ? '$imageUrl${snapshot[index].poster_path}'
              : '$imageBlueUrl',
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
                child: Text(
                  '${snapshot[index].title.length < 15 ? snapshot[index].title : snapshot[index].title.substring(0, 15) + '..'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Text(
                  ' (${snapshot[index].release_date.toString().substring(0, 4)})',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
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
              Container(
                child: Text(
                  '${snapshot[index].vote_average}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  openDetailsScreen(BuildContext context, Movie movie) {
    Navigator.pushNamed(context, '/detail', arguments: movie);
  }

  clearSearch(BuildContext context) {
    searchController.clear();
    Navigator.pop(context);
  }
}
