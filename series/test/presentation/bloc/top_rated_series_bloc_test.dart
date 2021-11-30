import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:series/presentation/bloc/top_rated/top_rated_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TopRatedSeriesBloc topRatedSeriesBloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();

    topRatedSeriesBloc =
        TopRatedSeriesBloc(getTopRatedSeries: mockGetTopRatedSeries);
  });

  group('Top Rated Series', () {
    test('initial state should be empty', () {
      expect(
        topRatedSeriesBloc.state,
        TopRatedSeriesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(testSerieList));

        return topRatedSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiateTopRatedSeriesEvent()),
      expect: () => [
        TopRatedSeriesLoading(const [], ''),
        TopRatedSeriesHasData(testSerieList, '')
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiateTopRatedSeriesEvent()),
      expect: () => [
        TopRatedSeriesLoading(const [], ''),
        TopRatedSeriesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );
  });
}
