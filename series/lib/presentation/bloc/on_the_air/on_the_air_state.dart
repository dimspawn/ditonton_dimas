// ignore_for_file: must_be_immutable

part of 'on_the_air_bloc.dart';

abstract class OnTheAirSeriesState extends Equatable {
  List<Serie> onTheAirSeries;
  String message;
  OnTheAirSeriesState({
    required this.onTheAirSeries,
    required this.message,
  });
}

class OnTheAirSeriesEmpty extends OnTheAirSeriesState {
  OnTheAirSeriesEmpty(
    List<Serie> onTheAirSeries,
    String message,
  ) : super(
          onTheAirSeries: onTheAirSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        onTheAirSeries,
        message,
      ];
}

class OnTheAirSeriesLoading extends OnTheAirSeriesState {
  OnTheAirSeriesLoading(
    List<Serie> onTheAirSeries,
    String message,
  ) : super(
          onTheAirSeries: onTheAirSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        onTheAirSeries,
        message,
      ];
}

class OnTheAirSeriesError extends OnTheAirSeriesState {
  OnTheAirSeriesError(
    List<Serie> onTheAirSeries,
    String message,
  ) : super(
          onTheAirSeries: onTheAirSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        onTheAirSeries,
        message,
      ];
}

class OnTheAirSeriesHasData extends OnTheAirSeriesState {
  OnTheAirSeriesHasData(
    List<Serie> onTheAirSeries,
    String message,
  ) : super(
          onTheAirSeries: onTheAirSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        onTheAirSeries,
        message,
      ];
}
