// ignore_for_file: must_be_immutable

part of 'now_playing_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  List<Movie> nowPlayingMovies;
  String message;
  NowPlayingMoviesState({
    required this.nowPlayingMovies,
    required this.message,
  });
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {
  NowPlayingMoviesEmpty(
    List<Movie> nowPlayingMovies,
    String message,
  ) : super(
          nowPlayingMovies: nowPlayingMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        nowPlayingMovies,
        message,
      ];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  NowPlayingMoviesLoading(
    List<Movie> nowPlayingMovies,
    String message,
  ) : super(
          nowPlayingMovies: nowPlayingMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        nowPlayingMovies,
        message,
      ];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  NowPlayingMoviesError(
    List<Movie> nowPlayingMovies,
    String message,
  ) : super(
          nowPlayingMovies: nowPlayingMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        nowPlayingMovies,
        message,
      ];
}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  NowPlayingMoviesHasData(
    List<Movie> nowPlayingMovies,
    String message,
  ) : super(
          nowPlayingMovies: nowPlayingMovies,
          message: message,
        );
  @override
  List<Object?> get props => [
        nowPlayingMovies,
        message,
      ];
}
