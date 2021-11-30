import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  List<Movie> _watchlistMovies = [];
  String _message = '';

  WatchlistMoviesBloc({
    required this.getWatchlistMovies,
  }) : super(
          WatchlistMoviesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiateWatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading(
        _watchlistMovies,
        _message,
      ));

      final watchlistSeriesListResult = await getWatchlistMovies.execute();
      watchlistSeriesListResult.fold((failure) {
        _message = failure.message;
        emit(WatchlistMoviesError(
          _watchlistMovies,
          _message,
        ));
      }, (watchlistSeries) {
        _watchlistMovies = watchlistSeries;
        emit(WatchlistMoviesHasData(
          _watchlistMovies,
          _message,
        ));
      });
    });
  }
}
