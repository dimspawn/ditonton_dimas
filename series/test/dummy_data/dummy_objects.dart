import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:series/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:series/presentation/bloc/popular/popular_series_bloc.dart';
import 'package:series/presentation/bloc/search/search_series_bloc.dart';
import 'package:series/presentation/bloc/top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist/watchlist_series_bloc.dart';

final testWatchlistSerie = Serie.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testSerie = Serie(
  name: 'The Rising of the Shield Hero',
  backdropPath: '/qSgBzXdu6QwVVeqOYOlHolkLRxZ.jpg',
  firstAirDate: '2019-01-09',
  genreIds: const [16, 10759, 10765, 18],
  id: 83095,
  originalName: '盾の勇者の成り上がり',
  overview:
      "Iwatani Naofumi was summoned into a parallel world along with 3 other people to become the world's Heroes. Each of the heroes respectively equipped with their own legendary equipment when summoned, Naofumi received the Legendary Shield as his weapon. Due to Naofumi's lack of charisma and experience he's labeled as the weakest, only to end up betrayed, falsely accused, and robbed by on the third day of adventure. Shunned by everyone from the king to peasants, Naofumi's thoughts were filled with nothing but vengeance and hatred. Thus, his destiny in a parallel World begins...",
  popularity: 66.569,
  posterPath: '/6cXf5EDwVhsRv8GlBzUTVnWuk8Z.jpg',
  voteAverage: 9,
  voteCount: 695,
);

final testSerieList = [testSerie];

SeriesDetail testSerieDetail = const SeriesDetail(
    name: 'name',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [
      Genre(
        id: 1,
        name: 'name',
      )
    ],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    seasons: [
      Season(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ]);

SeriesDetailLoading sdLoading = SeriesDetailLoading(
  testSerieDetail,
  const [],
  false,
  '',
);

SeriesDetailHasDataRecSuccess sdHasData = SeriesDetailHasDataRecSuccess(
  testSerieDetail,
  testSerieList,
  false,
  '',
);

SeriesDetailHasDataRecSuccess sdHasDataWatchlisted =
    SeriesDetailHasDataRecSuccess(
  testSerieDetail,
  testSerieList,
  true,
  '',
);

SeriesDetailAddWatchlist sdHasDataSuccessAddedData = SeriesDetailAddWatchlist(
  testSerieDetail,
  testSerieList,
  false,
  'Added to Series Watchlist',
);

SeriesDetailRemoveWatchlist sdHasDataSuccessRemovedData =
    SeriesDetailRemoveWatchlist(
  testSerieDetail,
  testSerieList,
  true,
  'Removed From Series Watchlist',
);

SeriesDetailWatchlistError sdHasDataFailed = SeriesDetailWatchlistError(
  testSerieDetail,
  testSerieList,
  false,
  'Failed To Save or Remove Data',
);

SeriesDetailError sdError = SeriesDetailError(
  testSerieDetail,
  testSerieList,
  false,
  'Error To Load Page',
);

PopularSeriesLoading psLoading = PopularSeriesLoading(
  testSerieList,
  '',
);

PopularSeriesHasData psHasData = PopularSeriesHasData(
  testSerieList,
  '',
);

PopularSeriesError psError = PopularSeriesError(
  testSerieList,
  'Failed To Get Popular Series',
);

OnTheAirSeriesLoading otaLoading = OnTheAirSeriesLoading(
  testSerieList,
  '',
);

OnTheAirSeriesHasData otaHasData = OnTheAirSeriesHasData(
  testSerieList,
  '',
);

OnTheAirSeriesError otaError = OnTheAirSeriesError(
  testSerieList,
  'Failed To Get On The Air Series',
);

TopRatedSeriesLoading trsLoading = TopRatedSeriesLoading(
  testSerieList,
  '',
);

TopRatedSeriesHasData trsHasData = TopRatedSeriesHasData(
  testSerieList,
  '',
);

TopRatedSeriesError trsError = TopRatedSeriesError(
  testSerieList,
  'Failed To Get Top Rated Series',
);

SearchSeriesEmpty ssEmpty = SearchSeriesEmpty(
  testSerieList,
  '',
);

SearchSeriesLoading ssLoading = SearchSeriesLoading(
  testSerieList,
  '',
);

SearchSeriesHasData ssHasData = SearchSeriesHasData(
  testSerieList,
  '',
);

SearchSeriesError ssError = SearchSeriesError(
  testSerieList,
  'Failed to Search Series',
);

WatchlistSeriesLoading wsLoading = WatchlistSeriesLoading(
  testSerieList,
  '',
);

WatchlistSeriesHasData wsHasData = WatchlistSeriesHasData(
  testSerieList,
  '',
);

WatchlistSeriesError wsError = WatchlistSeriesError(
  testSerieList,
  'Error Watchlist Database',
);
