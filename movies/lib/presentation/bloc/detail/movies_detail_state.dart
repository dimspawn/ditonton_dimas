// ignore_for_file: must_be_immutable

part of 'movies_detail_bloc.dart';

abstract class MoviesDetailState extends Equatable {
  MovieDetail movieDetail;
  List<Movie> moviesList;
  bool isAdded;
  String message;
  MoviesDetailState({
    required this.movieDetail,
    required this.moviesList,
    required this.isAdded,
    required this.message,
  });
}

class MoviesDetailEmpty extends MoviesDetailState {
  MoviesDetailEmpty(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );
  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailLoading extends MoviesDetailState {
  MoviesDetailLoading(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailError extends MoviesDetailState {
  MoviesDetailError(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailHasDataRecSuccess extends MoviesDetailState {
  MoviesDetailHasDataRecSuccess(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailHasDataRecFail extends MoviesDetailState {
  MoviesDetailHasDataRecFail(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailAddWatchlist extends MoviesDetailState {
  MoviesDetailAddWatchlist(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailRemoveWatchlist extends MoviesDetailState {
  MoviesDetailRemoveWatchlist(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}

class MoviesDetailWatchlistError extends MoviesDetailState {
  MoviesDetailWatchlistError(
    MovieDetail movieDetail,
    List<Movie> moviesList,
    bool isAdded,
    String message,
  ) : super(
          movieDetail: movieDetail,
          moviesList: moviesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        movieDetail,
        moviesList,
        isAdded,
        message,
      ];
}
