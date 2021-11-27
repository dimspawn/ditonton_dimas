import 'package:flutter/material.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:series/domain/usecases/get_on_the_air_series.dart';

class OnTheAirNotifier extends ChangeNotifier {
  final GetOnTheAirSeries getOnTheAirSeries;

  OnTheAirNotifier(this.getOnTheAirSeries);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Serie> _series = [];
  List<Serie> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirSeries.execute();

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
