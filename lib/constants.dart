import 'dart:ui';

const mPrimaryColor = Color(0xff05070c);
const mAccentColor = Color(0xff4B97C5);
const mBlue = Color(0xff0984e3);
const mDarkBlue1 = Color(0xff314665);
const mDarkBlue2 = Color(0xff253250);
const mLightGrey = Color(0xffb5b6bf);

const apiKey = 'e0006e65d0ed3abc9b55fb77dece9d2e';

const nowPlayingApi =
    'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';

const popularApi = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

const topRatedApi =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

const upcomingApi =
    'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

const search =
    'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=';

const imageUrl = 'https://image.tmdb.org/t/p/w1280';

const imageBlueUrl = 'https://www.beautycolorcode.com/253250-2880x1800.png';
