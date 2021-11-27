// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Serie extends Equatable {
  String? name;
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  Serie({
    required this.name,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Serie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
