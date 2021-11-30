part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent {
  const TopRatedMoviesEvent();
}

class InitiateTopRatedMoviesEvent extends TopRatedMoviesEvent {
  const InitiateTopRatedMoviesEvent();
}
