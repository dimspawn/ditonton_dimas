import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season_detail.dart';

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
