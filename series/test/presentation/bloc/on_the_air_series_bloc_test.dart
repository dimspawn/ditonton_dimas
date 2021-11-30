import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:series/presentation/bloc/on_the_air/on_the_air_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late OnTheAirSeriesBloc onTheAirSeriesBloc;
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;

  setUp(() {
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();

    onTheAirSeriesBloc =
        OnTheAirSeriesBloc(getOnTheAirSeries: mockGetOnTheAirSeries);
  });

  group('On The Air Series', () {
    test('initial state should be empty', () {
      expect(
        onTheAirSeriesBloc.state,
        OnTheAirSeriesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirSeries.execute())
            .thenAnswer((_) async => Right(testSerieList));

        return onTheAirSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiateOnTheAirSeriesEvent()),
      expect: () => [
        OnTheAirSeriesLoading(const [], ''),
        OnTheAirSeriesHasData(testSerieList, '')
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirSeries.execute());
      },
    );

    blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return onTheAirSeriesBloc;
      },
      act: (bloc) => bloc.add(const InitiateOnTheAirSeriesEvent()),
      expect: () => [
        OnTheAirSeriesLoading(const [], ''),
        OnTheAirSeriesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirSeries.execute());
      },
    );
  });
}
