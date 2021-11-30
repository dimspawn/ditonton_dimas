import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_movies_watchlist.dart';
import 'package:movies/domain/usecases/save_movies_watchlist.dart';

part 'movies_detail_event.dart';
part 'movies_detail_state.dart';

class MoviesDetailBloc extends Bloc<MovieDetailEvent, MoviesDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchlistStatusMovies getWatchlistStatusMovies;
  final SaveMoviesWatchlist saveMoviesWatchlist;
  final RemoveMoviesWatchlist removeMoviesWatchlist;

  late MovieDetail _movieDetail;
  List<Movie> _moviesList = [];
  bool _isAdded = false;
  String _message = '';

  MoviesDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchlistStatusMovies,
    required this.saveMoviesWatchlist,
    required this.removeMoviesWatchlist,
  }) : super(
          MoviesDetailEmpty(
            const MovieDetail(
              adult: false,
              backdropPath: 'backdropPath',
              genres: [Genre(id: 1, name: 'name')],
              id: 1,
              originalTitle: 'originalTitle',
              overview: 'overview',
              posterPath: 'posterPath',
              releaseDate: 'releaseDate',
              runtime: 120,
              title: 'title',
              voteAverage: 1,
              voteCount: 1,
            ),
            const [],
            false,
            '',
          ),
        ) {
    on<InitiateDetailMovies>(
      (event, emit) async {
        emit(MoviesDetailLoading(
            state.movieDetail, state.moviesList, state.isAdded, state.message));
        final id = event.id;
        final moviesResult = await getMovieDetail.execute(id);
        final recommendationsResult = await getMovieRecommendations.execute(id);
        _isAdded = await getWatchlistStatusMovies.execute(id);

        moviesResult.fold(
          (failure) {
            _message = failure.message;
            emit(MoviesDetailError(
              state.movieDetail,
              state.moviesList,
              _isAdded,
              _message,
            ));
          },
          (data) {
            _movieDetail = data;
            recommendationsResult.fold(
              (failure) {
                _message = failure.message;
                emit(
                  MoviesDetailHasDataRecFail(
                    _movieDetail,
                    state.moviesList,
                    _isAdded,
                    _message,
                  ),
                );
              },
              (recData) {
                _moviesList = recData;
                emit(
                  MoviesDetailHasDataRecSuccess(
                    _movieDetail,
                    _moviesList,
                    _isAdded,
                    state.message,
                  ),
                );
              },
            );
          },
        );
      },
    );

    on<AddWatchlistMoviesEvent>(
      (event, emit) async {
        final movies = event.movieDetail;
        final result = await saveMoviesWatchlist.execute(movies);

        _isAdded = await getWatchlistStatusMovies.execute(movies.id);

        result.fold(
          (failure) {
            _message = failure.message;
            emit(
              MoviesDetailWatchlistError(
                state.movieDetail,
                state.moviesList,
                _isAdded,
                _message,
              ),
            );
          },
          (successMessage) {
            _message = successMessage;
            emit(
              MoviesDetailAddWatchlist(
                state.movieDetail,
                state.moviesList,
                _isAdded,
                _message,
              ),
            );
          },
        );
      },
    );

    on<RemoveWatchlistMoviesEvent>(
      (event, emit) async {
        final movies = event.movieDetail;
        final result = await removeMoviesWatchlist.execute(movies);

        _isAdded = await getWatchlistStatusMovies.execute(movies.id);

        result.fold(
          (failure) {
            _message = failure.message;
            emit(
              MoviesDetailWatchlistError(
                state.movieDetail,
                state.moviesList,
                _isAdded,
                _message,
              ),
            );
          },
          (successMessage) {
            _message = successMessage;
            emit(
              MoviesDetailRemoveWatchlist(
                state.movieDetail,
                state.moviesList,
                _isAdded,
                _message,
              ),
            );
          },
        );
      },
    );
  }
}
