import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/usecases/get_watchlist_status_series.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchListStatusSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchListStatusSeries(mockMovieRepository);
  });

  test('should get watchlist series status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlistSeries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
