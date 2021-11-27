import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SeriesDetailBloc seriesDetailBloc;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListStatusSeries mockGetWatchListStatusSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchListStatusSeries = MockGetWatchListStatusSeries();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();

    seriesDetailBloc = SeriesDetailBloc(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListStatusSeries: mockGetWatchListStatusSeries,
      saveWatchlistSeries: mockSaveWatchlistSeries,
      removeWatchlistSeries: mockRemoveWatchlistSeries,
    );
  });

  group('Series Detail', () {
    test('initial state should be empty', () {
      expect(seriesDetailBloc.state, SeriesDetailEmpty());
    });

    const mockId = 1;

    final tSerieBloc = Serie(
      name: 'name',
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: const [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
    );

    final tSeriesBloc = <Serie>[tSerieBloc];
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetSeriesDetail.execute(mockId))
            .thenAnswer((_) async => const Right(testSerieDetail));
        when(mockGetSeriesRecommendations.execute(mockId))
            .thenAnswer((_) async => Right(tSeriesBloc));
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailSeries(mockId)),
      expect: () => [
        SeriesDetailLoading(),
        SeriesDetailHasData(
          result: testSerieDetail,
          recommendations: tSeriesBloc,
          isWatchlist: false,
          message: '',
        ),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(mockId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetSeriesDetail.execute(mockId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetSeriesRecommendations.execute(mockId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailSeries(mockId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(mockId));
      },
    );
  });
}
