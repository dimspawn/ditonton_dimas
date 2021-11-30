import 'package:core/domain/entities/serie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;

  List<Serie> _topRatedSeries = [];
  String _message = '';

  TopRatedSeriesBloc({
    required this.getTopRatedSeries,
  }) : super(
          TopRatedSeriesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiateTopRatedSeriesEvent>((event, emit) async {
      emit(TopRatedSeriesLoading(
        _topRatedSeries,
        _message,
      ));

      final topRatedSeriesListResult = await getTopRatedSeries.execute();
      topRatedSeriesListResult.fold((failure) {
        _message = failure.message;
        emit(TopRatedSeriesError(
          _topRatedSeries,
          _message,
        ));
      }, (topRatedSeries) {
        _topRatedSeries = topRatedSeries;
        emit(TopRatedSeriesHasData(
          _topRatedSeries,
          _message,
        ));
      });
    });
  }
}
