import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/presentation/bloc/detail/movies_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MoviesDetailBloc moviesDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchlistStatusMovies mockGetWatchlistStatusMovies;
  late MockSaveMoviesWatchlist mockSaveMoviesWatchlist;
  late MockRemoveMoviesWatchlist mockRemoveMoviesWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatusMovies = MockGetWatchlistStatusMovies();
    mockSaveMoviesWatchlist = MockSaveMoviesWatchlist();
    mockRemoveMoviesWatchlist = MockRemoveMoviesWatchlist();

    moviesDetailBloc = MoviesDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchlistStatusMovies: mockGetWatchlistStatusMovies,
      saveMoviesWatchlist: mockSaveMoviesWatchlist,
      removeMoviesWatchlist: mockRemoveMoviesWatchlist,
    );
  });

  group('Movies Detail', () {
    const mockId = 1;

    test('initial state should be empty', () {
      expect(
        moviesDetailBloc.state,
        MoviesDetailEmpty(
          testMovieDetail,
          const [],
          false,
          '',
        ),
      );
    });

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [Loading, HasDataRecFail] when data is gotten successfully but recommendations Error',
      build: () {
        when(mockGetMovieDetail.execute(mockId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(mockId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => false);
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailMovies(mockId)),
      expect: () => [
        MoviesDetailLoading(testMovieDetail, const [], false, ''),
        MoviesDetailHasDataRecFail(
            testMovieDetail, const [], false, 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(mockId));
      },
    );

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [Loading, HasDataRecSucces] when data and recommendations is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(mockId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(mockId))
            .thenAnswer((_) async => Right(testMovieList));
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => false);
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailMovies(mockId)),
      expect: () => [
        MoviesDetailLoading(testMovieDetail, const [], false, ''),
        MoviesDetailHasDataRecSuccess(testMovieDetail, testMovieList, false, '')
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(mockId));
      },
    );

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [Loading, Error] when get series detail is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(mockId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(mockId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => false);
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const InitiateDetailMovies(mockId)),
      expect: () => [
        MoviesDetailLoading(testMovieDetail, const [], false, ''),
        MoviesDetailError(testMovieDetail, const [], false, 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(mockId));
      },
    );

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [AddWatchlist] when get watchlist added successfully',
      build: () {
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => true);
        when(mockSaveMoviesWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Series Watchlist'));
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistMoviesEvent(testMovieDetail)),
      expect: () => [
        MoviesDetailAddWatchlist(
            testMovieDetail, const [], true, 'Added to Series Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveMoviesWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [ErrorAddWatchlist] when get watchlist add unsuccessful',
      build: () {
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => false);
        when(mockSaveMoviesWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistMoviesEvent(testMovieDetail)),
      expect: () => [
        MoviesDetailWatchlistError(
            testMovieDetail, const [], false, 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSaveMoviesWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [RemoveWatchlist] when get watchlist removed successfully',
      build: () {
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => false);
        when(mockRemoveMoviesWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right('Removed From Series Watchlist'));
        return moviesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveWatchlistMoviesEvent(testMovieDetail)),
      expect: () => [
        MoviesDetailRemoveWatchlist(
            testMovieDetail, const [], false, 'Removed From Series Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveMoviesWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MoviesDetailBloc, MoviesDetailState>(
      'Should emit [ErrorRemoveWatchlist] when get watchlist remove unsuccessful',
      build: () {
        when(mockGetWatchlistStatusMovies.execute(mockId))
            .thenAnswer((_) async => true);
        when(mockRemoveMoviesWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return moviesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveWatchlistMoviesEvent(testMovieDetail)),
      expect: () => [
        MoviesDetailWatchlistError(
            testMovieDetail, const [], true, 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockRemoveMoviesWatchlist.execute(testMovieDetail));
      },
    );
  });
}
