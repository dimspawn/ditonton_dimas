import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_movies_watchlist.dart';
import 'package:movies/domain/usecases/save_movies_watchlist.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Movie Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Movie Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchlistStatusMovies getWatchlistStatusMovies;
  final SaveMoviesWatchlist saveMoviesWatchlist;
  final RemoveMoviesWatchlist removeMoviesWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchlistStatusMovies,
    required this.saveMoviesWatchlist,
    required this.removeMoviesWatchlist,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationsState = RequestState.empty;
  RequestState get recommendationState => _recommendationsState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.loading;
    notifyListeners();

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold((failure) {
      _movieState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (movie) {
      _recommendationsState = RequestState.loading;
      _movie = movie;
      notifyListeners();
      recommendationResult.fold((failure) {
        _recommendationsState = RequestState.error;
        _message = failure.message;
      }, (movies) {
        _recommendationsState = RequestState.loaded;
        _movieRecommendations = movies;
      });
      _movieState = RequestState.loaded;
      notifyListeners();
    });
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveMoviesWatchlist.execute(movie);

    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (successMessage) async {
      _watchlistMessage = successMessage;
    });

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeMoviesWatchlist.execute(movie);

    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (successMessage) async {
      _watchlistMessage = successMessage;
    });

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatusMovies.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
