import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:season/presentation/bloc/list/season_detail_bloc.dart';

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

SeasonDetailLoading sddLoading = SeasonDetailLoading(
  testSeasonDetail,
  '',
);

SeasonDetailHasData sddHasData = SeasonDetailHasData(
  testSeasonDetail,
  '',
);

SeasonDetailError sddError = SeasonDetailError(
  testSeasonDetail,
  'Failed To Get Top Rated Series',
);
