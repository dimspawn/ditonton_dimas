import 'package:core/domain/entities/season_detail.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:season/domain/usecases/get_season_detail.dart';

class SeasonDetailNotifier extends ChangeNotifier {
  final GetSeasonDetail getSeasonDetail;

  SeasonDetailNotifier({required this.getSeasonDetail});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  late SeasonDetail _seasonDetail;
  SeasonDetail get seasonDetail => _seasonDetail;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetail(int id, int seasonNumber) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getSeasonDetail.execute(id, seasonNumber);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (seasonDetail) {
      _seasonDetail = seasonDetail;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
