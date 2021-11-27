import 'package:core/domain/entities/serie.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/provider/top_rated_series_notifier.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesNotifier notifier;
  late int listenerCallCountSeries;

  setUp(() {
    listenerCallCountSeries = 0;
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    notifier = TopRatedSeriesNotifier(getTopRatedSeries: mockGetTopRatedSeries)
      ..addListener(() {
        listenerCallCountSeries++;
      });
  });

  final tSerie = Serie(
    name: 'name',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 10.0,
    posterPath: 'posterPath',
    voteAverage: 8.0,
    voteCount: 1,
  );

  final tSerieList = <Serie>[tSerie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedSeries.execute())
        .thenAnswer((_) async => Right(tSerieList));
    // act
    notifier.fetchTopRatedSeries();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCountSeries, 1);
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedSeries.execute())
        .thenAnswer((_) async => Right(tSerieList));
    // act
    await notifier.fetchTopRatedSeries();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.series, tSerieList);
    expect(listenerCallCountSeries, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedSeries();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCountSeries, 2);
  });
}
