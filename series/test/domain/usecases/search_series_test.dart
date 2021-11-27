import 'package:core/domain/entities/serie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/usecases/search_series.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchSeries(mockMovieRepository);
  });

  final tSeries = <Serie>[];
  const tQuery = 'Spiderman';

  test('should get list of series from the repository', () async {
    // arrange
    when(mockMovieRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}
