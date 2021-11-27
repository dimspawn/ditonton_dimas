import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeriesDetail extends Equatable {
  final String name;
  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;

  const SeriesDetail({
    required this.name,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
  });

  @override
  List<Object?> get props => [
        name,
        backdropPath,
        firstAirDate,
        genres,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfSeasons,
        seasons
      ];
}
