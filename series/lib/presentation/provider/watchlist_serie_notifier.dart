import 'package:core/domain/entities/serie.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';

class WatchlistSeriesNotifier extends ChangeNotifier {
  var _watchlistSeries = <Serie>[];
  List<Serie> get watchlistSeries => _watchlistSeries;

  var _watchlistSeriesState = RequestState.empty;
  RequestState get watchlistSeriesState => _watchlistSeriesState;

  String _message = '';
  String get message => _message;

  final GetWatchlistSeries getWatchlistSeries;

  WatchlistSeriesNotifier({required this.getWatchlistSeries});

  Future<void> fetchWatchlistSeries() async {
    _watchlistSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold(
      (failure) {
        _watchlistSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _watchlistSeriesState = RequestState.loaded;
        _watchlistSeries = seriesData;
        notifyListeners();
      },
    );
  }
}
