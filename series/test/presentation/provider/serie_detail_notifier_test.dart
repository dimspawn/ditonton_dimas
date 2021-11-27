import 'package:core/domain/entities/serie.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/provider/serie_detail_notifier.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SeriesDetailNotifier provider;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListStatusSeries mockGetWatchListStatusSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late int listenerCallCountSeries;

  setUp(() {
    listenerCallCountSeries = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchListStatusSeries = MockGetWatchListStatusSeries();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    provider = SeriesDetailNotifier(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListStatusSeries: mockGetWatchListStatusSeries,
      saveWatchlistSeries: mockSaveWatchlistSeries,
      removeWatchlistSeries: mockRemoveWatchlistSeries,
    )..addListener(() {
        listenerCallCountSeries += 1;
      });
  });

  const tId = 1;

  final tSerie = Serie(
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

  final tSeries = <Serie>[tSerie];

  void _arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => const Right(testSerieDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeries));
  }

  group('Get Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.serieState, RequestState.loading);
      expect(listenerCallCountSeries, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.serieState, RequestState.loaded);
      expect(provider.serie, testSerieDetail);
      expect(listenerCallCountSeries, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.serieState, RequestState.loaded);
      expect(provider.seriesRecommendations, tSeries);
    });
  });

  group('Get Serie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesRecommendations.execute(tId));
      expect(provider.seriesRecommendations, tSeries);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.seriesRecommendations, tSeries);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Right(testSerieDetail));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist Series', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListStatusSeries.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistSeriesStatus(1);
      // assert
      expect(provider.isAddedToWatchlistSeries, true);
    });

    test('should execute save watchlist series when function called', () async {
      // arrange
      when(mockSaveWatchlistSeries.execute(testSerieDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListStatusSeries.execute(testSerieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistSeries(testSerieDetail);
      // assert
      verify(mockSaveWatchlistSeries.execute(testSerieDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistSeries.execute(testSerieDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListStatusSeries.execute(testSerieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistSeries(testSerieDetail);
      // assert
      verify(mockRemoveWatchlistSeries.execute(testSerieDetail));
    });

    test('should update watchlist series status when add watchlist success',
        () async {
      // arrange
      when(mockSaveWatchlistSeries.execute(testSerieDetail))
          .thenAnswer((_) async => const Right('Added to Series Watchlist'));
      when(mockGetWatchListStatusSeries.execute(testSerieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistSeries(testSerieDetail);
      // assert
      verify(mockGetWatchListStatusSeries.execute(testSerieDetail.id));
      expect(provider.isAddedToWatchlistSeries, true);
      expect(provider.watchlistMessageSeries, 'Added to Series Watchlist');
      expect(listenerCallCountSeries, 1);
    });

    test('should update watchlist series message when add watchlist failed',
        () async {
      // arrange
      when(mockSaveWatchlistSeries.execute(testSerieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatusSeries.execute(testSerieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistSeries(testSerieDetail);
      // assert
      expect(provider.watchlistMessageSeries, 'Failed');
      expect(listenerCallCountSeries, 1);
    });
  });

  group('on Error Series', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeries));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.serieState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCountSeries, 2);
    });
  });
}
