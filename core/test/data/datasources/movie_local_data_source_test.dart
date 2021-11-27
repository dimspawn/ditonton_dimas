import 'package:core/data/datasources/movie_local_data_source.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Movie Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Movie Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail by Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getFilmById(tId, 'movies'))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getFilmById(tId, 'movies'))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  test('should throw CacheException when cache data is not exist', () async {
    // arrange
    when(mockDatabaseHelper.getCacheFilm('movies')).thenAnswer((_) async => []);
    // act
    final call = dataSource.getCachedNowPlayingMovies();
    // assert
    expect(() => call, throwsA(isA<CacheException>()));
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arramge
      when(mockDatabaseHelper.getWatchlistFilm('movies'))
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call databse helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('movies')).thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingMovies([testMovieCache]);
      // assert
      verify(mockDatabaseHelper
          .insertCacheTransaction([testMovieCache], 'movies'));
    });
  });

  group('save watchlist series', () {
    test('should return success message when insert to database is success',
        () async {
      // arange
      when(mockDatabaseHelper.insertWatchlistSeries(testSerieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistSeries(testSerieTable);
      // assert
      expect(result, 'Added to Series Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arange
      when(mockDatabaseHelper.insertWatchlistSeries(testSerieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistSeries(testSerieTable);
      // assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist series', () {
    test('should return success message when remove from database is success',
        () async {
      // arange
      when(mockDatabaseHelper.removeWatchlistSeries(testSerieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWathclistSeries(testSerieTable);
      // assert
      expect(result, 'Removed from Series Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSeries(testSerieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWathclistSeries(testSerieTable);
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Serie Detail by Id', () {
    const tId = 1;

    test('should return Serie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getFilmById(tId, 'series'))
          .thenAnswer((_) async => testSerieMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, testSerieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getFilmById(tId, 'series'))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  test('should throw CacheException when cache series data is not exist',
      () async {
    // arrange
    when(mockDatabaseHelper.getCacheFilm('series')).thenAnswer((_) async => []);
    // act
    final call = dataSource.getCachedOnTheAirSeries();
    // assert
    expect(() => call, throwsA(isA<CacheException>()));
  });

  group('get watchlist series', () {
    test('should return list of SerieTable from database', () async {
      // arramge
      when(mockDatabaseHelper.getWatchlistFilm('series'))
          .thenAnswer((_) async => [testSerieMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [testSerieTable]);
    });
  });

  group('cache on the air series', () {
    test('should call databse helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('series')).thenAnswer((_) async => 1);
      // act
      await dataSource.cacheOnTheAirSeries([testSerieCache]);
      // assert
      verify(mockDatabaseHelper
          .insertCacheTransactionSeries([testSerieCache], 'series'));
    });
  });
}
