import 'package:demo/models/login_model.dart';
import 'package:demo/models/movie_model.dart';
import 'package:demo/screens/movie_home_page.dart';
import 'package:demo/screens/search.dart';
import 'package:demo/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/detail_movie.dart';
import 'screens/login_sceen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieViewModel(),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        routes: {
          LoginScreen.routeLogin: (context) => LoginScreen(),
          MovieHomePage.routeHome: (context) => MovieHomePage(),
          DetailMovie.routeDetail: (context) => DetailMovie(),
          Search.routeSearch: (context) => Search()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
