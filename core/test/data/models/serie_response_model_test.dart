import 'dart:convert';

import 'package:core/data/models/serie_model.dart';
import 'package:core/data/models/serie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tSerieModel = SeriesModel(
    name: 'name',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tSerieResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSerieModel]);

  group('fromJson Series', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSerieResponseModel);
    });
  });

  group('toJson Series', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSerieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "name": "name",
            "backdrop_path": "backdropPath",
            "first_air_date": "firstAirDate",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "posterPath",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
