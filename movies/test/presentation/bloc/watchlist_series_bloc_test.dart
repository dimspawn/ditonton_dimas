import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/presentation/bloc/watchlist/watchlist_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();

    watchlistMoviesBloc =
        WatchlistMoviesBloc(getWatchlistMovies: mockGetWatchlistMovies);
  });

  group('Watchlist Movies', () {
    test('initial state should be empty', () {
      expect(
        watchlistMoviesBloc.state,
        WatchlistMoviesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiateWatchlistMoviesEvent()),
      expect: () => [
        WatchlistMoviesLoading(const [], ''),
        WatchlistMoviesHasData(testMovieList, '')
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiateWatchlistMoviesEvent()),
      expect: () => [
        WatchlistMoviesLoading(const [], ''),
        WatchlistMoviesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
