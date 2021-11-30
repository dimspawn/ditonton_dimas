import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:series/presentation/bloc/watchlist/watchlist_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late WatchlistSeriesBloc watchlistSeriesBloc;
  late MockGetWatchlistSeries mockGetWatchlistSeries;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();

    watchlistSeriesBloc =
        WatchlistSeriesBloc(getWatchlistSeries: mockGetWatchlistSeries);
  });

  group('Watchlist Series', () {
    test('initial state should be empty', () {
      expect(
        watchlistSeriesBloc.state,
        WatchlistSeriesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => Right(testSerieList));

        return watchlistSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiateWatchlistSeriesEvent()),
      expect: () => [
        WatchlistSeriesLoading(const [], ''),
        WatchlistSeriesHasData(testSerieList, '')
      ],
      verify: (bloc) {
        verify(mockGetWatchlistSeries.execute());
      },
    );

    blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiateWatchlistSeriesEvent()),
      expect: () => [
        WatchlistSeriesLoading(const [], ''),
        WatchlistSeriesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetWatchlistSeries.execute());
      },
    );
  });
}
