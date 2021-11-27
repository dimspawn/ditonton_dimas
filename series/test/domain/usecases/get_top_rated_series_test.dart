import 'package:core/domain/entities/serie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/usecases/get_top_rated_series.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedSeries(mockMovieRepository);
  });

  final tSeries = <Serie>[];

  test('should get list of series from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
