import 'package:core/data/models/serie_model.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const SeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory SeriesTable.fromEntity(SeriesDetail series) => SeriesTable(
        id: series.id,
        title: series.name,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map["id"],
        title: map["title"],
        posterPath: map["posterPath"],
        overview: map["overview"],
      );

  factory SeriesTable.fromDTO(SeriesModel series) => SeriesTable(
        id: series.id,
        title: series.name,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'category': "series"
      };

  Serie toEntity() => Serie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
