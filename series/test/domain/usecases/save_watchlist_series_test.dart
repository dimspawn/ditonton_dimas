import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistSeries(mockMovieRepository);
  });

  test('should save serie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlistSeries(testSerieDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSerieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlistSeries(testSerieDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
