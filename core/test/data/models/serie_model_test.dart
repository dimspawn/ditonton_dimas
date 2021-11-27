import 'package:core/data/models/serie_model.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSerieModel = SeriesModel(
    name: 'name',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 10.0,
    posterPath: 'posterPath',
    voteAverage: 8.0,
    voteCount: 1,
  );

  final tSerie = Serie(
    name: 'name',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 10.0,
    posterPath: 'posterPath',
    voteAverage: 8.0,
    voteCount: 1,
  );

  test('should be a subclass of Serie entity', () async {
    final result = tSerieModel.toEntity();
    expect(result, tSerie);
  });
}
