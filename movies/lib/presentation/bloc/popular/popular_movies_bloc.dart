import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  List<Movie> _popularMovies = [];
  String _message = '';

  PopularMoviesBloc({
    required this.getPopularMovies,
  }) : super(
          PopularMoviesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiatePopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesLoading(
        _popularMovies,
        _message,
      ));

      final popularMoviesListResult = await getPopularMovies.execute();
      popularMoviesListResult.fold((failure) {
        _message = failure.message;
        emit(PopularMoviesError(
          _popularMovies,
          _message,
        ));
      }, (popularData) {
        _popularMovies = popularData;
        emit(PopularMoviesHasData(
          _popularMovies,
          _message,
        ));
      });
    });
  }
}
