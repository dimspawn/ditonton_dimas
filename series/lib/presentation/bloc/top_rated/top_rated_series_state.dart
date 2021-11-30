// ignore_for_file: must_be_immutable

part of 'top_rated_series_bloc.dart';

abstract class TopRatedSeriesState extends Equatable {
  List<Serie> topRatedSeries;
  String message;
  TopRatedSeriesState({
    required this.topRatedSeries,
    required this.message,
  });
}

class TopRatedSeriesEmpty extends TopRatedSeriesState {
  TopRatedSeriesEmpty(
    List<Serie> topRatedSeries,
    String message,
  ) : super(
          topRatedSeries: topRatedSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedSeries,
        message,
      ];
}

class TopRatedSeriesLoading extends TopRatedSeriesState {
  TopRatedSeriesLoading(
    List<Serie> topRatedSeries,
    String message,
  ) : super(
          topRatedSeries: topRatedSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedSeries,
        message,
      ];
}

class TopRatedSeriesError extends TopRatedSeriesState {
  TopRatedSeriesError(
    List<Serie> topRatedSeries,
    String message,
  ) : super(
          topRatedSeries: topRatedSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedSeries,
        message,
      ];
}

class TopRatedSeriesHasData extends TopRatedSeriesState {
  TopRatedSeriesHasData(
    List<Serie> topRatedSeries,
    String message,
  ) : super(
          topRatedSeries: topRatedSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        topRatedSeries,
        message,
      ];
}
