import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/detail/movies_detail_bloc.dart';
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/search/search_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/bloc/watchlist/watchlist_movies_bloc.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);
final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
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
);

const testMovieDetailtime60 = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 50,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);

MoviesDetailLoading mdLoading = MoviesDetailLoading(
  testMovieDetail,
  const [],
  false,
  '',
);

MoviesDetailHasDataRecSuccess mdHasData = MoviesDetailHasDataRecSuccess(
  testMovieDetail,
  testMovieList,
  false,
  '',
);

MoviesDetailHasDataRecSuccess mdHasDataTime60 = MoviesDetailHasDataRecSuccess(
  testMovieDetailtime60,
  testMovieList,
  false,
  '',
);

MoviesDetailHasDataRecSuccess mdHasDataWatchlisted =
    MoviesDetailHasDataRecSuccess(
  testMovieDetail,
  testMovieList,
  true,
  '',
);

MoviesDetailAddWatchlist mdHasDataSuccessAddedData = MoviesDetailAddWatchlist(
  testMovieDetail,
  testMovieList,
  false,
  'Added to Movies Watchlist',
);

MoviesDetailRemoveWatchlist mdHasDataSuccessRemovedData =
    MoviesDetailRemoveWatchlist(
  testMovieDetail,
  testMovieList,
  true,
  'Removed From Movies Watchlist',
);

MoviesDetailWatchlistError mdHasDataFailed = MoviesDetailWatchlistError(
  testMovieDetail,
  testMovieList,
  false,
  'Failed To Save or Remove Data',
);

MoviesDetailError mdError = MoviesDetailError(
  testMovieDetail,
  testMovieList,
  false,
  'Movie Detail Page Fail to Load',
);

PopularMoviesLoading pmLoading = PopularMoviesLoading(
  testMovieList,
  '',
);

PopularMoviesHasData pmHasData = PopularMoviesHasData(
  testMovieList,
  '',
);

PopularMoviesError pmError = PopularMoviesError(
  testMovieList,
  'Failed To Get Popular Movies',
);

TopRatedMoviesLoading trmLoading = TopRatedMoviesLoading(
  testMovieList,
  '',
);

TopRatedMoviesHasData trmHasData = TopRatedMoviesHasData(
  testMovieList,
  '',
);

TopRatedMoviesError trmError = TopRatedMoviesError(
  testMovieList,
  'Failed To Get Top Rated Movies',
);

SearchMoviesEmpty smEmpty = SearchMoviesEmpty(
  testMovieList,
  '',
);

SearchMoviesLoading smLoading = SearchMoviesLoading(
  testMovieList,
  '',
);

SearchMoviesHasData smHasData = SearchMoviesHasData(
  testMovieList,
  '',
);

SearchMoviesError smError = SearchMoviesError(
  testMovieList,
  'Failed to Search Movies',
);

WatchlistMoviesLoading wmLoading = WatchlistMoviesLoading(
  testMovieList,
  '',
);

WatchlistMoviesHasData wmHasData = WatchlistMoviesHasData(
  testMovieList,
  '',
);

WatchlistMoviesError wmError = WatchlistMoviesError(
  testMovieList,
  'Error Watchlist Database',
);
