// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/data/models/serie_detail_model.dart';
import 'package:core/data/models/serie_model.dart';
import 'package:core/data/models/serie_response.dart';
import 'package:core/utils/connection.dart';
import 'package:core/utils/exception.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<SeriesModel>> getOnTheAirSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
  Future<SeriesDetailResponse> getSeriesDetail(int id);
  Future<List<SeriesModel>> getSeriesRecommendations(int id);
  Future<List<SeriesModel>> searchSeries(String query);
  Future<SeasonDetailResponse> getSeasonDetail(int id, int seasonNumber);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=bc64203d9789bfe5a2185d4c651c5602';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final Connection conn;

  MovieRemoteDataSourceImpl({required this.conn});

  //---Movie---
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    // final response =
    //     await conn.execUrl('$BASE_URL/movie/now_playing?$API_KEY'));
    final response = await conn.execUrl('$BASE_URL/movie/now_playing?$API_KEY');
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await conn.execUrl('$BASE_URL/movie/$id?$API_KEY');

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response =
        await conn.execUrl('$BASE_URL/movie/$id/recommendations?$API_KEY');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await conn.execUrl('$BASE_URL/movie/popular?$API_KEY');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await conn.execUrl('$BASE_URL/movie/top_rated?$API_KEY');
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response =
        await conn.execUrl('$BASE_URL/search/movie?$API_KEY&query=$query');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  //---End-of-Movie---
  //---Series---
  @override
  Future<List<SeriesModel>> getOnTheAirSeries() async {
    final response = await conn.execUrl('$BASE_URL/tv/on_the_air?$API_KEY');
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailResponse> getSeriesDetail(int id) async {
    final response = await conn.execUrl('$BASE_URL/tv/$id?$API_KEY');

    if (response.statusCode == 200) {
      return SeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getSeriesRecommendations(int id) async {
    final response =
        await conn.execUrl('$BASE_URL/tv/$id/recommendations?$API_KEY');

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response = await conn.execUrl('$BASE_URL/tv/popular?$API_KEY');

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response = await conn.execUrl('$BASE_URL/tv/top_rated?$API_KEY');
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response =
        await conn.execUrl('$BASE_URL/search/tv?$API_KEY&query=$query');

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailResponse> getSeasonDetail(int id, int seasonNumber) async {
    final response =
        await conn.execUrl('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY');

    if (response.statusCode == 200) {
      return SeasonDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
  //---End-of-Serie---
}
