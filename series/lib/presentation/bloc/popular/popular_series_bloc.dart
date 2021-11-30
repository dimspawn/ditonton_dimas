import 'package:core/domain/entities/serie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries getPopularSeries;

  List<Serie> _popularSeries = [];
  String _message = '';

  PopularSeriesBloc({
    required this.getPopularSeries,
  }) : super(
          PopularSeriesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiatePopularSeriesEvent>((event, emit) async {
      emit(PopularSeriesLoading(
        _popularSeries,
        _message,
      ));

      final popularSeriesListResult = await getPopularSeries.execute();
      popularSeriesListResult.fold((failure) {
        _message = failure.message;
        emit(PopularSeriesError(
          _popularSeries,
          _message,
        ));
      }, (popularData) {
        _popularSeries = popularData;
        emit(PopularSeriesHasData(
          _popularSeries,
          _message,
        ));
      });
    });
  }
}
