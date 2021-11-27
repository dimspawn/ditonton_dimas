import 'package:core/domain/entities/serie.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/usecases/get_on_the_air_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _onTheAirSeries = <Serie>[];
  List<Serie> get onTheAirSeries => _onTheAirSeries;

  RequestState _onTheAirState = RequestState.empty;
  RequestState get onTheAirState => _onTheAirState;

  var _popularSeries = <Serie>[];
  List<Serie> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Serie>[];
  List<Serie> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message = '';
  String get message => _message;

  final GetOnTheAirSeries getOnTheAirSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  SeriesListNotifier({
    required this.getOnTheAirSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  });

  Future<void> fetchOnTheAirSeries() async {
    _onTheAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirSeries.execute();
    result.fold((failure) {
      _onTheAirState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _onTheAirState = RequestState.loaded;
      _onTheAirSeries = seriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold((failure) {
      _popularSeriesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _popularSeriesState = RequestState.loaded;
      _popularSeries = seriesData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold((failure) {
      _topRatedSeriesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _topRatedSeriesState = RequestState.loaded;
      _topRatedSeries = seriesData;
      notifyListeners();
    });
  }
}
