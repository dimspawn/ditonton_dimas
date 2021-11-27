import 'package:core/domain/entities/serie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_serie_recommendations.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetSeriesRecommendations(mockMovieRepository);
  });

  const tId = 1;
  final tSeries = <Serie>[];

  test('should get list of serie recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSeries));
  });
}
