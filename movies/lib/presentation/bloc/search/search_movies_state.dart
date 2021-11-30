// ignore_for_file: prefer_const_constructors_in_immutables

part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  final List<Movie> result;
  final String message;
  const SearchMoviesState({
    required this.result,
    required this.message,
  });
}

class SearchMoviesEmpty extends SearchMoviesState {
  SearchMoviesEmpty(
    List<Movie> result,
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

class SearchMoviesLoading extends SearchMoviesState {
  SearchMoviesLoading(
    List<Movie> result,
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

class SearchMoviesError extends SearchMoviesState {
  SearchMoviesError(
    List<Movie> result,
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

class SearchMoviesHasData extends SearchMoviesState {
  SearchMoviesHasData(
    List<Movie> result,
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
