import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
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

  late SeriesDetail _seriesDetail;
  List<Serie> _seriesList = [];
  bool _isAdded = false;
  String _message = '';

  SeriesDetailBloc({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListStatusSeries,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
  }) : super(
          SeriesDetailEmpty(
            const SeriesDetail(
              name: 'name',
              backdropPath: 'backdropPath',
              firstAirDate: 'firstAirDate',
              genres: [Genre(id: 1, name: 'name')],
              id: 1,
              originalName: 'originalName',
              overview: 'overview',
              popularity: 1.0,
              posterPath: 'posterPath',
              voteAverage: 1,
              voteCount: 1,
              numberOfEpisodes: 1,
              numberOfSeasons: 1,
              seasons: [
                Season(
                  airDate: 'airDate',
                  episodeCount: 1,
                  id: 1,
                  name: 'name',
                  overview: 'overview',
                  posterPath: 'posterPath',
                  seasonNumber: 1,
                )
              ],
            ),
            const [],
            false,
            '',
          ),
        ) {
    on<InitiateDetailSeries>(
      (event, emit) async {
        emit(SeriesDetailLoading(state.seriesDetail, state.seriesList,
            state.isAdded, state.message));
        final id = event.id;
        final seriesResult = await getSeriesDetail.execute(id);
        final recommendationsResult =
            await getSeriesRecommendations.execute(id);
        _isAdded = await getWatchListStatusSeries.execute(id);

        seriesResult.fold(
          (failure) {
            _message = failure.message;
            emit(SeriesDetailError(
              state.seriesDetail,
              state.seriesList,
              _isAdded,
              _message,
            ));
          },
          (data) {
            _seriesDetail = data;
            recommendationsResult.fold(
              (failure) {
                _message = failure.message;
                emit(
                  SeriesDetailHasDataRecFail(
                    _seriesDetail,
                    state.seriesList,
                    _isAdded,
                    _message,
                  ),
                );
              },
              (recData) {
                _seriesList = recData;
                emit(
                  SeriesDetailHasDataRecSuccess(
                    _seriesDetail,
                    _seriesList,
                    _isAdded,
                    state.message,
                  ),
                );
              },
            );
          },
        );
      },
    );

    on<AddWatchlistSeriesEvent>(
      (event, emit) async {
        final series = event.seriesDetail;
        final result = await saveWatchlistSeries.execute(series);

        _isAdded = await getWatchListStatusSeries.execute(series.id);

        result.fold(
          (failure) {
            _message = failure.message;
            emit(
              SeriesDetailWatchlistError(
                state.seriesDetail,
                state.seriesList,
                _isAdded,
                _message,
              ),
            );
          },
          (successMessage) {
            _message = successMessage;
            emit(
              SeriesDetailAddWatchlist(
                state.seriesDetail,
                state.seriesList,
                _isAdded,
                _message,
              ),
            );
          },
        );
      },
    );

    on<RemoveWatchlistSeriesEvent>(
      (event, emit) async {
        final series = event.seriesDetail;
        final result = await removeWatchlistSeries.execute(series);

        _isAdded = await getWatchListStatusSeries.execute(series.id);

        result.fold(
          (failure) {
            _message = failure.message;
            emit(
              SeriesDetailWatchlistError(
                state.seriesDetail,
                state.seriesList,
                _isAdded,
                _message,
              ),
            );
          },
          (successMessage) {
            _message = successMessage;
            emit(
              SeriesDetailRemoveWatchlist(
                state.seriesDetail,
                state.seriesList,
                _isAdded,
                _message,
              ),
            );
          },
        );
      },
    );
  }
}
