import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:series/presentation/bloc/popular/popular_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late PopularSeriesBloc popularSeriesBloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();

    popularSeriesBloc =
        PopularSeriesBloc(getPopularSeries: mockGetPopularSeries);
  });

  group('Populer Series', () {
    test('initial state should be empty', () {
      expect(
        popularSeriesBloc.state,
        PopularSeriesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<PopularSeriesBloc, PopularSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(testSerieList));

        return popularSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiatePopularSeriesEvent()),
      expect: () => [
        PopularSeriesLoading(const [], ''),
        PopularSeriesHasData(testSerieList, '')
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<PopularSeriesBloc, PopularSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiatePopularSeriesEvent()),
      expect: () => [
        PopularSeriesLoading(const [], ''),
        PopularSeriesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );
  });
}
