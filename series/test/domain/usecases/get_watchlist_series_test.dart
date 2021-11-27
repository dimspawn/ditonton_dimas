import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/usecases/get_watchlist_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistSeries(mockMovieRepository);
  });

  test('should get list of series from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistSeries())
        .thenAnswer((_) async => Right(testSerieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testSerieList));
  });
}
