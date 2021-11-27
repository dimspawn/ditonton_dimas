import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:season/domain/usecases/get_season_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetSeasonDetail(mockMovieRepository);
  });

  const tId = 1;
  const seasonNumber = 1;

  test('should get season detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getSeasonDetail(tId, seasonNumber))
        .thenAnswer((realInvocation) async => const Right(testSeasonDetail));
    // act
    final result = await usecase.execute(tId, seasonNumber);
    // assert
    expect(result, const Right(testSeasonDetail));
  });
}
