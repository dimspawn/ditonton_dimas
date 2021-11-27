import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/usecases/get_serie_detail.dart';
import 'package:series/domain/usecases/get_serie_recommendations.dart';
import 'package:series/domain/usecases/get_watchlist_status_series.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListStatusSeries getWatchListStatusSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  late SeriesDetail _serie;
  SeriesDetail get serie => _serie;

  List<Serie> _seriesRecommendations = [];
  List<Serie> get seriesRecommendations => _seriesRecommendations;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistSeries = false;
  bool get isAddedToWatchlistSeries => _isAddedtoWatchlistSeries;

  SeriesDetailBloc({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListStatusSeries,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
  }) : super(SeriesDetailEmpty());

  @override
  Stream<SeriesDetailState> mapEventToState(SeriesDetailEvent event) async* {
    if (event is InitiateDetailSeries) {
      yield SeriesDetailLoading();
      final id = event.id;
      final result = await getSeriesDetail.execute(id);
      final recommendSeriesResult = await getSeriesRecommendations.execute(id);

      yield* result.fold(
        (failure) async* {
          yield SeriesDetailError(failure.message);
        },
        (data) async* {
          _serie = data;
          _isAddedtoWatchlistSeries =
              await getWatchListStatusSeries.execute(id);

          yield* recommendSeriesResult.fold((recFail) async* {
            yield SeriesDetailError(recFail.message);
          }, (recData) async* {
            _seriesRecommendations = recData;
            yield SeriesDetailHasData(
              result: _serie,
              recommendations: _seriesRecommendations,
              isWatchlist: _isAddedtoWatchlistSeries,
              message: _message,
            );
          });
        },
      );
    }

    if (event is AddWatchlistSeriesEvent) {
      yield SeriesDetailLoading();
      final series = event.seriesDetail;
      final result = await saveWatchlistSeries.execute(series);

      _isAddedtoWatchlistSeries =
          await getWatchListStatusSeries.execute(series.id);

      yield* result.fold(
        (failure) async* {
          yield SeriesDetailHasData(
            result: _serie,
            recommendations: _seriesRecommendations,
            isWatchlist: _isAddedtoWatchlistSeries,
            message: failure.message,
          );
          _message = failure.message;
        },
        (successMessage) async* {
          yield SeriesDetailHasData(
            result: _serie,
            recommendations: _seriesRecommendations,
            isWatchlist: _isAddedtoWatchlistSeries,
            message: successMessage,
          );
          _message = successMessage;
        },
      );
    }

    if (event is RemoveWatchlistSeriesEvent) {
      final series = event.seriesDetail;
      final result = await removeWatchlistSeries.execute(series);

      yield* result.fold(
        (failure) async* {
          _message = failure.message;
        },
        (successMessage) async* {
          _message = successMessage;
        },
      );

      _isAddedtoWatchlistSeries =
          await getWatchListStatusSeries.execute(series.id);
      yield SeriesDetailHasData(
        result: _serie,
        recommendations: _seriesRecommendations,
        isWatchlist: _isAddedtoWatchlistSeries,
        message: _message,
      );
    }
  }
}
