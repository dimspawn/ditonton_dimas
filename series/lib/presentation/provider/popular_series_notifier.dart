import 'package:core/domain/entities/serie.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier(this.getPopularSeries);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Serie> _series = [];
  List<Serie> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (seriesData) {
      _series = seriesData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
