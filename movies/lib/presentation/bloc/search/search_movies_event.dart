part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent {
  const SearchMoviesEvent();
}

class OnQueryChanged extends SearchMoviesEvent {
  final String query;

  const OnQueryChanged(this.query);
}
