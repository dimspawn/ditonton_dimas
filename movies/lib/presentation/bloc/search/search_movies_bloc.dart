import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  List<Movie> _searchMovies = [];
  String _message = '';

  SearchMoviesBloc(this.searchMovies)
      : super(SearchMoviesEmpty(
          const [],
          '',
        )) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchMoviesLoading(
          _searchMovies,
          _message,
        ));
        final result = await searchMovies.execute(query);

        result.fold(
          (failure) {
            _message = failure.message;
            emit(SearchMoviesError(
              _searchMovies,
              _message,
            ));
          },
          (data) {
            _searchMovies = data;
            emit(SearchMoviesHasData(
              _searchMovies,
              _message,
            ));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
