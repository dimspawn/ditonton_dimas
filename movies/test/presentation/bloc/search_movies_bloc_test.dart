import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/search/search_movies_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(
      searchMoviesBloc.state,
      SearchMoviesEmpty(
        const [],
        '',
      ),
    );
  });

  const tQuery = 'helikopter';

  group('Search Movies', () {
    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(testMovieList));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMoviesLoading(const [], ''),
        SearchMoviesHasData(testMovieList, ''),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMoviesLoading(const [], ''),
        SearchMoviesError(const [], 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
