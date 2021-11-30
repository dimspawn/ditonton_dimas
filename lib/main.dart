// ignore_for_file: use_key_in_widget_constructors

import 'package:ditonton_dimas/injection.dart' as di;
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:home/presentation/pages/home_movie_page.dart';
import 'package:home/presentation/pages/about_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/search_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:season/presentation/pages/season_detail_page.dart';
import 'package:series/presentation/pages/on_the_air_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:series/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:series/presentation/bloc/popular/popular_series_bloc.dart';
import 'package:series/presentation/bloc/search/search_series_bloc.dart';
import 'package:series/presentation/bloc/top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist/watchlist_series_bloc.dart';
import 'package:movies/presentation/bloc/detail/movies_detail_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/search/search_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/bloc/watchlist/watchlist_movies_bloc.dart';
import 'package:season/presentation/bloc/list/season_detail_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeasonDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMovieRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviesRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case watchlistMovieRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case onTheAirRoute:
              return MaterialPageRoute(builder: (_) => OnTheAirSeriesPage());
            case popularSerieRoute:
              return MaterialPageRoute(builder: (_) => PopularSeriesPage());
            case topRatedSeriesRoute:
              return MaterialPageRoute(builder: (_) => TopRatedSeriesPage());
            case serieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case searchSerieRoute:
              return MaterialPageRoute(builder: (_) => SearchSeriesPage());
            case watchlistSerieRoute:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case seasonDetailRoute:
              final arg = settings.arguments as Map;
              final id = arg['id'] as int;
              final seasonNumber = arg['seasonNumber'] as int;
              return MaterialPageRoute(
                builder: (_) => SeasonDetailPage(
                  id: id,
                  seasonNumber: seasonNumber,
                ),
                settings: settings,
              );
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
