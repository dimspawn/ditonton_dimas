import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/serie_table.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testSerieTable = SeriesTable(
  id: 1,
  title: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testSerieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'name',
};

const testMovieCache = MovieTable(
  id: 557,
  title: 'Spider-Man',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
);

const testSerieCache = SeriesTable(
  id: 83095,
  title: 'The Rising of the Shield Hero',
  posterPath: '/6cXf5EDwVhsRv8GlBzUTVnWuk8Z.jpg',
  overview:
      "Iwatani Naofumi was summoned into a parallel world along with 3 other people to become the world's Heroes. Each of the heroes respectively equipped with their own legendary equipment when summoned, Naofumi received the Legendary Shield as his weapon. Due to Naofumi's lack of charisma and experience he's labeled as the weakest, only to end up betrayed, falsely accused, and robbed by on the third day of adventure. Shunned by everyone from the king to peasants, Naofumi's thoughts were filled with nothing but vengeance and hatred. Thus, his destiny in a parallel World begins...",
);

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);
final testSerieFromCache = Serie.watchlist(
  id: 83095,
  overview:
      "Iwatani Naofumi was summoned into a parallel world along with 3 other people to become the world's Heroes. Each of the heroes respectively equipped with their own legendary equipment when summoned, Naofumi received the Legendary Shield as his weapon. Due to Naofumi's lack of charisma and experience he's labeled as the weakest, only to end up betrayed, falsely accused, and robbed by on the third day of adventure. Shunned by everyone from the king to peasants, Naofumi's thoughts were filled with nothing but vengeance and hatred. Thus, his destiny in a parallel World begins...",
  posterPath: '/6cXf5EDwVhsRv8GlBzUTVnWuk8Z.jpg',
  name: 'The Rising of the Shield Hero',
);

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
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
const testSerieDetail = SeriesDetail(
    name: 'name',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Anime')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 60.0,
    posterPath: 'posterPath',
    voteAverage: 8.0,
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
          seasonNumber: 1)
    ]);

const testSeasonDetail = SeasonDetail(
  airDate: 'airDate',
  episodes: [
    Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      stillPath: 'stillPath',
    ),
  ],
  name: 'name',
  overview: 'overview',
  id: 1,
  posterPath: 'posterPath',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);
final testWatchlistSerie = Serie.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);
