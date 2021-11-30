part of 'movies_detail_bloc.dart';

abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class InitiateDetailMovies extends MovieDetailEvent {
  final int id;
  const InitiateDetailMovies(this.id);
}

class AddWatchlistMoviesEvent extends MovieDetailEvent {
  final MovieDetail movieDetail;
  const AddWatchlistMoviesEvent(this.movieDetail);
}

class RemoveWatchlistMoviesEvent extends MovieDetailEvent {
  final MovieDetail movieDetail;
  const RemoveWatchlistMoviesEvent(this.movieDetail);
}
