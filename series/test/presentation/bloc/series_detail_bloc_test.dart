import 'package:bloc_test/bloc_test.dart';
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
    const mockId = 1;

    test('initial state should be empty', () {
      expect(
        seriesDetailBloc.state,
        SeriesDetailEmpty(
          testSerieDetail,
          const [],
          false,
          '',
        ),
      );
    });

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, HasDataRecFail] when data is gotten successfully but recommendations Error',
      build: () {
        when(mockGetSeriesDetail.execute(mockId))
            .thenAnswer((_) async => Right(testSerieDetail));
        when(mockGetSeriesRecommendations.execute(mockId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailSeries(mockId)),
      expect: () => [
        SeriesDetailLoading(testSerieDetail, const [], false, ''),
        SeriesDetailHasDataRecFail(
            testSerieDetail, const [], false, 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(mockId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, HasDataRecSucces] when data and recommendations is gotten successfully',
      build: () {
        when(mockGetSeriesDetail.execute(mockId))
            .thenAnswer((_) async => Right(testSerieDetail));
        when(mockGetSeriesRecommendations.execute(mockId))
            .thenAnswer((_) async => Right(testSerieList));
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailSeries(mockId)),
      expect: () => [
        SeriesDetailLoading(testSerieDetail, const [], false, ''),
        SeriesDetailHasDataRecSuccess(testSerieDetail, testSerieList, false, '')
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(mockId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Error] when get series detail is unsuccessful',
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
        SeriesDetailLoading(testSerieDetail, const [], false, ''),
        SeriesDetailError(testSerieDetail, const [], false, 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(mockId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [AddWatchlist] when get watchlist added successfully',
      build: () {
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => true);
        when(mockSaveWatchlistSeries.execute(testSerieDetail))
            .thenAnswer((_) async => const Right('Added to Series Watchlist'));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistSeriesEvent(testSerieDetail)),
      expect: () => [
        SeriesDetailAddWatchlist(
            testSerieDetail, const [], true, 'Added to Series Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistSeries.execute(testSerieDetail));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [ErrorAddWatchlist] when get watchlist add unsuccessful',
      build: () {
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => false);
        when(mockSaveWatchlistSeries.execute(testSerieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistSeriesEvent(testSerieDetail)),
      expect: () => [
        SeriesDetailWatchlistError(
            testSerieDetail, const [], false, 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistSeries.execute(testSerieDetail));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [RemoveWatchlist] when get watchlist removed successfully',
      build: () {
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => false);
        when(mockRemoveWatchlistSeries.execute(testSerieDetail)).thenAnswer(
            (_) async => const Right('Removed From Series Watchlist'));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistSeriesEvent(testSerieDetail)),
      expect: () => [
        SeriesDetailRemoveWatchlist(
            testSerieDetail, const [], false, 'Removed From Series Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeries.execute(testSerieDetail));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [ErrorRemoveWatchlist] when get watchlist remove unsuccessful',
      build: () {
        when(mockGetWatchListStatusSeries.execute(mockId))
            .thenAnswer((_) async => true);
        when(mockRemoveWatchlistSeries.execute(testSerieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistSeriesEvent(testSerieDetail)),
      expect: () => [
        SeriesDetailWatchlistError(
            testSerieDetail, const [], true, 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeries.execute(testSerieDetail));
      },
    );
  });
}
