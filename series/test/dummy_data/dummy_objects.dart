import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';

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
