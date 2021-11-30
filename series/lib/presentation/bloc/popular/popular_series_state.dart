// ignore_for_file: must_be_immutable

part of 'popular_series_bloc.dart';

abstract class PopularSeriesState extends Equatable {
  List<Serie> popularSeries;
  String message;
  PopularSeriesState({
    required this.popularSeries,
    required this.message,
  });
}

class PopularSeriesEmpty extends PopularSeriesState {
  PopularSeriesEmpty(
    List<Serie> popularSeries,
    String message,
  ) : super(
          popularSeries: popularSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularSeries,
        message,
      ];
}

class PopularSeriesLoading extends PopularSeriesState {
  PopularSeriesLoading(
    List<Serie> popularSeries,
    String message,
  ) : super(
          popularSeries: popularSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularSeries,
        message,
      ];
}

class PopularSeriesError extends PopularSeriesState {
  PopularSeriesError(
    List<Serie> popularSeries,
    String message,
  ) : super(
          popularSeries: popularSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularSeries,
        message,
      ];
}

class PopularSeriesHasData extends PopularSeriesState {
  PopularSeriesHasData(
    List<Serie> popularSeries,
    String message,
  ) : super(
          popularSeries: popularSeries,
          message: message,
        );
  @override
  List<Object?> get props => [
        popularSeries,
        message,
      ];
}
