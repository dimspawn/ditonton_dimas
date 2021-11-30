import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();

    nowPlayingMoviesBloc =
        NowPlayingMoviesBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  group('Now Playing Movies', () {
    test('initial state should be empty', () {
      expect(
        nowPlayingMoviesBloc.state,
        NowPlayingMoviesEmpty(
          const [],
          '',
        ),
      );
    });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiateNowPlayingMoviesEvent()),
      expect: () => [
        NowPlayingMoviesLoading(const [], ''),
        NowPlayingMoviesHasData(testMovieList, '')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(const InitiateNowPlayingMoviesEvent()),
      expect: () => [
        NowPlayingMoviesLoading(const [], ''),
        NowPlayingMoviesError(const [], 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
