import 'package:core/domain/entities/serie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_on_the_air_series.dart';

part 'on_the_air_event.dart';
part 'on_the_air_state.dart';

class OnTheAirSeriesBloc
    extends Bloc<OnTheAirSeriesEvent, OnTheAirSeriesState> {
  final GetOnTheAirSeries getOnTheAirSeries;

  List<Serie> _onTheAirSeries = [];
  String _message = '';

  OnTheAirSeriesBloc({
    required this.getOnTheAirSeries,
  }) : super(
          OnTheAirSeriesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiateOnTheAirSeriesEvent>((event, emit) async {
      emit(OnTheAirSeriesLoading(
        _onTheAirSeries,
        _message,
      ));

      final onTheAirResult = await getOnTheAirSeries.execute();
      onTheAirResult.fold((failure) {
        _message = failure.message;
        emit(OnTheAirSeriesError(
          _onTheAirSeries,
          _message,
        ));
      }, (onTheAirData) {
        _onTheAirSeries = onTheAirData;
        emit(OnTheAirSeriesHasData(
          _onTheAirSeries,
          _message,
        ));
      });
    });
  }
}
