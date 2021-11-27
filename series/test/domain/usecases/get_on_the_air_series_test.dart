import 'package:core/domain/entities/serie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/usecases/get_on_the_air_series.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetOnTheAirSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetOnTheAirSeries(mockMovieRepository);
  });

  final tSeries = <Serie>[];

  test('should get list of series from the repository', () async {
    // arrange
    when(mockMovieRepository.getOnTheAirSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
