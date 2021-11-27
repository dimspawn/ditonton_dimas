import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/serie_table.dart';
import 'package:core/utils/exception.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
  Future<String> insertWatchlistSeries(SeriesTable serie);
  Future<String> removeWathclistSeries(SeriesTable serie);
  Future<SeriesTable?> getSeriesById(int id);
  Future<List<SeriesTable>> getWatchlistSeries();
  Future<void> cacheOnTheAirSeries(List<SeriesTable> series);
  Future<List<SeriesTable>> getCachedOnTheAirSeries();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  //---Movies---
  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Movie Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Movie Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getFilmById(id, 'movies');
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistFilm('movies');
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache('movies');
    await databaseHelper.insertCacheTransaction(movies, 'movies');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheFilm('movies');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  //---End-of-Movie---
  //---Series---
  @override
  Future<String> insertWatchlistSeries(SeriesTable serie) async {
    try {
      await databaseHelper.insertWatchlistSeries(serie);
      return 'Added to Series Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWathclistSeries(SeriesTable serie) async {
    try {
      await databaseHelper.removeWatchlistSeries(serie);
      return 'Removed from Series Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getFilmById(id, 'series');
    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistFilm('series');
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheOnTheAirSeries(List<SeriesTable> series) async {
    await databaseHelper.clearCache('series');
    await databaseHelper.insertCacheTransactionSeries(series, 'series');
  }

  @override
  Future<List<SeriesTable>> getCachedOnTheAirSeries() async {
    final result = await databaseHelper.getCacheFilm('series');
    if (result.isNotEmpty) {
      return result.map((data) => SeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
  //---End-of-Series---
}
