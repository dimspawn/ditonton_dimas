// ignore_for_file: must_be_immutable

part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  List<Movie> topRatedMovies;
  String message;
  TopRatedMoviesState({
    required this.topRatedMovies,
    required this.message,
  });
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {
  TopRatedMoviesEmpty(
    List<Movie> topRatedMovies,
    String message,
  ) : super(
          topRatedMovies: topRatedMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedMovies,
        message,
      ];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  TopRatedMoviesLoading(
    List<Movie> topRatedMovies,
    String message,
  ) : super(
          topRatedMovies: topRatedMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedMovies,
        message,
      ];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  TopRatedMoviesError(
    List<Movie> topRatedMovies,
    String message,
  ) : super(
          topRatedMovies: topRatedMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedMovies,
        message,
      ];
}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  TopRatedMoviesHasData(
    List<Movie> topRatedMovies,
    String message,
  ) : super(
          topRatedMovies: topRatedMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedMovies,
        message,
      ];
}
