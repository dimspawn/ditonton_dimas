import 'package:core/domain/entities/serie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';

part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries getWatchlistSeries;

  List<Serie> _watchlistSeries = [];
  String _message = '';

  WatchlistSeriesBloc({
    required this.getWatchlistSeries,
  }) : super(
          WatchlistSeriesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiateWatchlistSeriesEvent>((event, emit) async {
      emit(WatchlistSeriesLoading(
        _watchlistSeries,
        _message,
      ));

      final watchlistSeriesListResult = await getWatchlistSeries.execute();
      watchlistSeriesListResult.fold((failure) {
        _message = failure.message;
        emit(WatchlistSeriesError(
          _watchlistSeries,
          _message,
        ));
      }, (watchlistSeries) {
        _watchlistSeries = watchlistSeries;
        emit(WatchlistSeriesHasData(
          _watchlistSeries,
          _message,
        ));
      });
    });
  }
}
