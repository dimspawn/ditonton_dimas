import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/usecases/get_serie_recommendations.dart';
import 'package:series/domain/usecases/get_serie_detail.dart';
import 'package:series/domain/usecases/get_watchlist_status_series.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Series Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Series Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListStatusSeries getWatchListStatusSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListStatusSeries,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
  });

  late SeriesDetail _serie;
  SeriesDetail get serie => _serie;

  RequestState _serieState = RequestState.empty;
  RequestState get serieState => _serieState;

  List<Serie> _seriesRecommendations = [];
  List<Serie> get seriesRecommendations => _seriesRecommendations;

  RequestState _recommendationsSeriesState = RequestState.empty;
  RequestState get recommendationState => _recommendationsSeriesState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistSeries = false;
  bool get isAddedToWatchlistSeries => _isAddedtoWatchlistSeries;

  Future<void> fetchSeriesDetail(int id) async {
    _serieState = RequestState.loading;
    notifyListeners();

    final detailResult = await getSeriesDetail.execute(id);
    final recommendationSeriesResult =
        await getSeriesRecommendations.execute(id);
    detailResult.fold((failure) {
      _serieState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (serieData) {
      _recommendationsSeriesState = RequestState.loading;
      _serie = serieData;
      notifyListeners();
      recommendationSeriesResult.fold((failure) {
        _recommendationsSeriesState = RequestState.error;
        _message = failure.message;
      }, (recSeriesData) {
        _recommendationsSeriesState = RequestState.loaded;
        _seriesRecommendations = recSeriesData;
      });
      _serieState = RequestState.loaded;
      notifyListeners();
    });
  }

  String _watchlistMessageSeries = '';
  String get watchlistMessageSeries => _watchlistMessageSeries;

  Future<void> addWatchlistSeries(SeriesDetail serie) async {
    final result = await saveWatchlistSeries.execute(serie);

    await result.fold((failure) async {
      _watchlistMessageSeries = failure.message;
    }, (successMessage) async {
      _watchlistMessageSeries = successMessage;
    });

    await loadWatchlistSeriesStatus(serie.id);
  }

  Future<void> removeFromWatchlistSeries(SeriesDetail serie) async {
    final result = await removeWatchlistSeries.execute(serie);

    await result.fold((failure) async {
      _watchlistMessageSeries = failure.message;
    }, (successMessage) async {
      _watchlistMessageSeries = successMessage;
    });

    await loadWatchlistSeriesStatus(serie.id);
  }

  Future<void> loadWatchlistSeriesStatus(int id) async {
    final result = await getWatchListStatusSeries.execute(id);
    _isAddedtoWatchlistSeries = result;
    notifyListeners();
  }
}
