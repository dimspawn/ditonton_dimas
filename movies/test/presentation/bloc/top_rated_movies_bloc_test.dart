import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();

    topRatedMoviesBloc =
        TopRatedMoviesBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  group('Top Rated Movies', () {
    test('initial state should be empty', () {
      expect(
        topRatedMoviesBloc.state,
        TopRatedMoviesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiateTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(const [], ''),
        TopRatedMoviesHasData(testMovieList, '')
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiateTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(const [], ''),
        TopRatedMoviesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
