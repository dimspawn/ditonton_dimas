// ignore_for_file: prefer_const_constructors_in_immutables

part of 'search_series_bloc.dart';

abstract class SearchSeriesState extends Equatable {
  final List<Serie> result;
  final String message;
  const SearchSeriesState({
    required this.result,
    required this.message,
  });
}

class SearchSeriesEmpty extends SearchSeriesState {
  SearchSeriesEmpty(
    List<Serie> result,
    String message,
  ) : super(
          result: result,
          message: message,
        );
  @override
  List<Object?> get props => [
        result,
        message,
      ];
}

class SearchSeriesLoading extends SearchSeriesState {
  SearchSeriesLoading(
    List<Serie> result,
    String message,
  ) : super(
          result: result,
          message: message,
        );
  @override
  List<Object?> get props => [
        result,
        message,
      ];
}

class SearchSeriesError extends SearchSeriesState {
  SearchSeriesError(
    List<Serie> result,
    String message,
  ) : super(
          result: result,
          message: message,
        );
  @override
  List<Object?> get props => [
        result,
        message,
      ];
}

class SearchSeriesHasData extends SearchSeriesState {
  SearchSeriesHasData(
    List<Serie> result,
    String message,
  ) : super(
          result: result,
          message: message,
        );
  @override
  List<Object?> get props => [
        result,
        message,
      ];
}
