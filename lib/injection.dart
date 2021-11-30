import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_reposiotry_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/network_info.dart';
import 'package:core/utils/connection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_movies_watchlist.dart';
import 'package:movies/domain/usecases/save_movies_watchlist.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:http/http.dart' as http;
import 'package:season/domain/usecases/get_season_detail.dart';
import 'package:series/domain/usecases/get_on_the_air_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_serie_detail.dart';
import 'package:series/domain/usecases/get_serie_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_status_series.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/domain/usecases/search_series.dart';
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

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirSeriesBloc(
      getOnTheAirSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularSeriesBloc(
      getPopularSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedSeriesBloc(
      getTopRatedSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistSeriesBloc(
      getWatchlistSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => MoviesDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchlistStatusMovies: locator(),
      saveMoviesWatchlist: locator(),
      removeMoviesWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesDetailBloc(
      getSeriesDetail: locator(),
      getSeriesRecommendations: locator(),
      getWatchListStatusSeries: locator(),
      saveWatchlistSeries: locator(),
      removeWatchlistSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchSeriesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => SeasonDetailBloc(
      getSeasonDetail: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusMovies(locator()));
  locator.registerLazySingleton(() => SaveMoviesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMoviesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetSeasonDetail(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(conn: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton(() => Connection());
}
