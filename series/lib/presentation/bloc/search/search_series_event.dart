part of 'search_series_bloc.dart';

abstract class SearchSeriesEvent {
  const SearchSeriesEvent();
}

class OnQueryChanged extends SearchSeriesEvent {
  final String query;
  const OnQueryChanged(this.query);
}
