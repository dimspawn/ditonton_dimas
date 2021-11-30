// ignore_for_file: must_be_immutable

part of 'watchlist_series_bloc.dart';

abstract class WatchlistSeriesState extends Equatable {
  List<Serie> watchlistSeries;
  String message;
  WatchlistSeriesState({
    required this.watchlistSeries,
    required this.message,
  });
}

class WatchlistSeriesEmpty extends WatchlistSeriesState {
  WatchlistSeriesEmpty(
    List<Serie> watchlistSeries,
    String message,
  ) : super(
          watchlistSeries: watchlistSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistSeries,
        message,
      ];
}

class WatchlistSeriesLoading extends WatchlistSeriesState {
  WatchlistSeriesLoading(
    List<Serie> watchlistSeries,
    String message,
  ) : super(
          watchlistSeries: watchlistSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistSeries,
        message,
      ];
}

class WatchlistSeriesError extends WatchlistSeriesState {
  WatchlistSeriesError(
    List<Serie> watchlistSeries,
    String message,
  ) : super(
          watchlistSeries: watchlistSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistSeries,
        message,
      ];
}

class WatchlistSeriesHasData extends WatchlistSeriesState {
  WatchlistSeriesHasData(
    List<Serie> watchlistSeries,
    String message,
  ) : super(
          watchlistSeries: watchlistSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        watchlistSeries,
        message,
      ];
}
