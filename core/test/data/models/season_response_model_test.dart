import 'dart:convert';

import 'package:core/data/models/episode_model.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    airDate: '2021-10-12',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'still_path',
  );

  const tSeasonResponseModel = SeasonDetailResponse(
    airDate: '2021-10-12',
    episodes: <EpisodeModel>[tEpisodeModel],
    name: 'name',
    overview: 'overview',
    id: 1,
    posterPath: 'poster_path',
  );

  group('fromJson Season', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/season_detail.json'));
      // act
      final result = SeasonDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeasonResponseModel);
    });
  });

  group('toJson Series', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "air_date": "2021-10-12",
        "episodes": [
          {
            "air_date": "2021-10-12",
            "episode_number": 1,
            "id": 1,
            "name": "name",
            "overview": "overview",
            "still_path": "still_path",
          }
        ],
        "name": "name",
        "overview": "overview",
        "id": 1,
        "poster_path": "poster_path"
      };
      expect(result, expectedJsonMap);
    });
  });
}
