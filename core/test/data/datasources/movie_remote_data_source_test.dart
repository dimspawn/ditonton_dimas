// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/data/models/serie_detail_model.dart';
import 'package:core/data/models/serie_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

import '../../helpers/test_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=bc64203d9789bfe5a2185d4c651c5602';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockConnection mockConnection;

  setUp(() {
    mockConnection = MockConnection();
    dataSource = MovieRemoteDataSourceImpl(conn: mockConnection);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/now_playing?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/now_playing?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/popular?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/popular?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/$tId?$API_KEY')).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/$tId?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockConnection
              .execUrl('$BASE_URL/movie/$tId/recommendations?$API_KEY'))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/movie_recommendations.json'), 200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection
              .execUrl('$BASE_URL/movie/$tId/recommendations?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockConnection
              .execUrl('$BASE_URL/search/movie?$API_KEY&query=$tQuery'))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockConnection
              .execUrl('$BASE_URL/search/movie?$API_KEY&query=$tQuery'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return top rated movies when the response code is 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/top_rated?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/movie/top_rated?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get On The Air Series', () {
    final tSerieList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air.json')))
        .seriesList;

    test('should return list of Serie Model when the response code is 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/on_the_air?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirSeries();
      // assert
      expect(result, equals(tSerieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/on_the_air?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_series.json')))
        .seriesList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/popular?$API_KEY')).thenAnswer(
          (_) async => http.Response(
                  readJson('dummy_data/popular_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/popular?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get serie detail', () {
    const tId = 83095;
    final tSerieDetail = SeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/serie_detail.json')));

    test('should return serie detail when the response code is 200', () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/$tId?$API_KEY')).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/serie_detail.json'), 200));
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tSerieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/$tId?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get serie recommendations', () {
    final tSerieList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/serie_recommendations.json')))
        .seriesList;
    const tId = 86034;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/$tId/recommendations?$API_KEY'))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/serie_recommendations.json'), 200));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSerieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/$tId/recommendations?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search series', () {
    final tSearchResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_shield_hero_serie.json')))
        .seriesList;
    const tQuery = 'Shield Hero';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/search/tv?$API_KEY&query=$tQuery'))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_shield_hero_serie.json'), 200));
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/search/tv?$API_KEY&query=$tQuery'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get season detail', () {
    const tId = 83095;
    const seasonNumber = 1;
    final tSeasonDetail = SeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/season_detail.json')));

    test('should return serie detail when the response code is 200', () async {
      // arrange
      when(mockConnection
              .execUrl('$BASE_URL/tv/$tId/season/$seasonNumber?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/season_detail.json'), 200));
      // act
      final result = await dataSource.getSeasonDetail(tId, seasonNumber);
      // assert
      expect(result, equals(tSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockConnection
              .execUrl('$BASE_URL/tv/$tId/season/$seasonNumber?$API_KEY'))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonDetail(tId, seasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated series', () {
    final tseriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_series.json')))
        .seriesList;

    test('should return top rated series when the response code is 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/top_rated?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_series.json'), 200));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, equals(tseriesList));
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockConnection.execUrl('$BASE_URL/tv/top_rated?$API_KEY'))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_series.json'), 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
