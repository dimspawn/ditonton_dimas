// ignore_for_file: must_be_immutable

part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  List<Movie> popularMovies;
  String message;
  PopularMoviesState({
    required this.popularMovies,
    required this.message,
  });
}

class PopularMoviesEmpty extends PopularMoviesState {
  PopularMoviesEmpty(
    List<Movie> popularMovies,
    String message,
  ) : super(
          popularMovies: popularMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularMovies,
        message,
      ];
}

class PopularMoviesLoading extends PopularMoviesState {
  PopularMoviesLoading(
    List<Movie> popularMovies,
    String message,
  ) : super(
          popularMovies: popularMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularMovies,
        message,
      ];
}

class PopularMoviesError extends PopularMoviesState {
  PopularMoviesError(
    List<Movie> popularMovies,
    String message,
  ) : super(
          popularMovies: popularMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularMovies,
        message,
      ];
}

class PopularMoviesHasData extends PopularMoviesState {
  PopularMoviesHasData(
    List<Movie> popularMovies,
    String message,
  ) : super(
          popularMovies: popularMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularMovies,
        message,
      ];
}
