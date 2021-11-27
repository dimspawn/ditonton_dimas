import 'package:core/domain/entities/serie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/usecases/get_popular_series.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularSeries(mockMovieRepository);
  });

  final tSeries = <Serie>[];

  group('Get Popular Series Tests', () {
    test(
        'should get list of series from the repository when execute function is called',
        () async {
      // arrange
      when(mockMovieRepository.getPopularSeries())
          .thenAnswer((_) async => Right(tSeries));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tSeries));
    });
  });
}
