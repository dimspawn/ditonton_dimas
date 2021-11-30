import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_serie_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetSeriesDetail(mockMovieRepository);
  });

  const tId = 1;

  test('should get serie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getSeriesDetail(tId))
        .thenAnswer((realInvocation) async => Right(testSerieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSerieDetail));
  });
}
