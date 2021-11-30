import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  List<Movie> _nowPlayingMovies = [];
  String _message = '';

  NowPlayingMoviesBloc({
    required this.getNowPlayingMovies,
  }) : super(
          NowPlayingMoviesEmpty(
            const [],
            '',
          ),
        ) {
    on<InitiateNowPlayingMoviesEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading(
        _nowPlayingMovies,
        _message,
      ));

      final onTheAirResult = await getNowPlayingMovies.execute();
      onTheAirResult.fold((failure) {
        _message = failure.message;
        emit(NowPlayingMoviesError(
          _nowPlayingMovies,
          _message,
        ));
      }, (onTheAirData) {
        _nowPlayingMovies = onTheAirData;
        emit(NowPlayingMoviesHasData(
          _nowPlayingMovies,
          _message,
        ));
      });
    });
  }
}
