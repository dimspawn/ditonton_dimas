import 'package:core/domain/entities/serie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistSeries {
  final MovieRepository repository;

  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail serie) {
    return repository.saveWatchlistSeries(serie);
  }
}
