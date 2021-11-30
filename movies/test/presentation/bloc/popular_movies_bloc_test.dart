import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();

    popularMoviesBloc =
        PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
  });

  group('Populer Movies', () {
    test('initial state should be empty', () {
      expect(
        popularMoviesBloc.state,
        PopularMoviesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiatePopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(const [], ''),
        PopularMoviesHasData(testMovieList, '')
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiatePopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(const [], ''),
        PopularMoviesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
