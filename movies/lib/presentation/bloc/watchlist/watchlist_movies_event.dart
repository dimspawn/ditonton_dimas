part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent {
  const WatchlistMoviesEvent();
}

class InitiateWatchlistMoviesEvent extends WatchlistMoviesEvent {
  const InitiateWatchlistMoviesEvent();
}
