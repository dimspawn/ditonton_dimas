import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/provider/watchlist_serie_notifier.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late WatchlistSeriesNotifier provider;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late int listenerCallCountSeries;

  setUp(() {
    listenerCallCountSeries = 0;
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    provider = WatchlistSeriesNotifier(
      getWatchlistSeries: mockGetWatchlistSeries,
    )..addListener(() {
        listenerCallCountSeries += 1;
      });
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistSeries.execute())
        .thenAnswer((_) async => Right([testWatchlistSerie]));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistSeriesState, RequestState.loaded);
    expect(provider.watchlistSeries, [testWatchlistSerie]);
    expect(listenerCallCountSeries, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistSeries.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistSeriesState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCountSeries, 2);
  });
}
