import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetPopularSeries {
  final MovieRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Serie>>> execute() {
    return repository.getPopularSeries();
  }
}
