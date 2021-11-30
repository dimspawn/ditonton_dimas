part of 'watchlist_series_bloc.dart';

abstract class WatchlistSeriesEvent {
  const WatchlistSeriesEvent();
}

class InitiateWatchlistSeriesEvent extends WatchlistSeriesEvent {
  const InitiateWatchlistSeriesEvent();
}
