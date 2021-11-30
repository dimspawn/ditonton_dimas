import 'package:core/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_movies_watchlist.dart';
import 'package:movies/domain/usecases/save_movies_watchlist.dart';
import 'package:movies/domain/usecases/search_movies.dart';

@GenerateMocks([
  MovieRepository,
  SearchMovies,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistStatusMovies,
  GetWatchlistMovies,
  SaveMoviesWatchlist,
  RemoveMoviesWatchlist,
])
void main() {}
