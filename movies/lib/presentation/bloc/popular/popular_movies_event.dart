part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent {
  const PopularMoviesEvent();
}

class InitiatePopularMoviesEvent extends PopularMoviesEvent {
  const InitiatePopularMoviesEvent();
}
