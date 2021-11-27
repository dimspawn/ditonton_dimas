import 'package:core/domain/entities/serie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistSeries {
  final MovieRepository repository;

  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail serie) {
    return repository.removeWathclistSeries(serie);
  }
}
