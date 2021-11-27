import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  //---Movies---
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWathclist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  //---Series---
  Future<Either<Failure, List<Serie>>> getWatchlistSeries();
  Future<Either<Failure, List<Serie>>> getOnTheAirSeries();
  Future<Either<Failure, List<Serie>>> getPopularSeries();
  Future<Either<Failure, List<Serie>>> getTopRatedSeries();
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Serie>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Serie>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlistSeries(SeriesDetail series);
  Future<Either<Failure, String>> removeWathclistSeries(SeriesDetail series);
  Future<bool> isAddedToWatchlistSeries(int id);
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
      int id, int seasonNumber);
}
