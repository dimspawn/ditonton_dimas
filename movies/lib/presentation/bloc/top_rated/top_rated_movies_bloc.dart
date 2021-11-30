import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  List<Movie> _topRatedMovies = [];
  String _message = '';

  TopRatedMoviesBloc({
    required this.getTopRatedMovies,
  }) : super(
          TopRatedMoviesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiateTopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading(
        _topRatedMovies,
        _message,
      ));

      final topRatedSeriesListResult = await getTopRatedMovies.execute();
      topRatedSeriesListResult.fold((failure) {
        _message = failure.message;
        emit(TopRatedMoviesError(
          _topRatedMovies,
          _message,
        ));
      }, (topRatedSeries) {
        _topRatedMovies = topRatedSeries;
        emit(TopRatedMoviesHasData(
          _topRatedMovies,
          _message,
        ));
      });
    });
  }
}
