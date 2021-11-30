// ignore_for_file: must_be_immutable

part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  List<Movie> watchlistMovies;
  String message;
  WatchlistMoviesState({
    required this.watchlistMovies,
    required this.message,
  });
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {
  WatchlistMoviesEmpty(
    List<Movie> watchlistMovies,
    String message,
  ) : super(
          watchlistMovies: watchlistMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistMovies,
        message,
      ];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  WatchlistMoviesLoading(
    List<Movie> watchlistMovies,
    String message,
  ) : super(
          watchlistMovies: watchlistMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistMovies,
        message,
      ];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  WatchlistMoviesError(
    List<Movie> watchlistMovies,
    String message,
  ) : super(
          watchlistMovies: watchlistMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistMovies,
        message,
      ];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  WatchlistMoviesHasData(
    List<Movie> watchlistMovies,
    String message,
  ) : super(
          watchlistMovies: watchlistMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistMovies,
        message,
      ];
}
