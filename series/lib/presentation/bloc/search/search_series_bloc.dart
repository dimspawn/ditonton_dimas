import 'package:core/domain/entities/serie.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:rxdart/rxdart.dart';

part 'search_series_event.dart';
part 'search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries searchSeries;

  List<Serie> _searchSeries = [];
  String _message = '';

  SearchSeriesBloc(this.searchSeries)
      : super(SearchSeriesEmpty(
          const [],
          '',
        )) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchSeriesLoading(
          _searchSeries,
          _message,
        ));
        final result = await searchSeries.execute(query);

        result.fold(
          (failure) {
            _message = failure.message;
            emit(SearchSeriesError(
              _searchSeries,
              _message,
            ));
          },
          (data) {
            _searchSeries = data;
            emit(SearchSeriesHasData(
              _searchSeries,
              _message,
            ));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
