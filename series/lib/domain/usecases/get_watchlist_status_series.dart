import 'package:core/domain/repositories/movie_repository.dart';

class GetWatchListStatusSeries {
  final MovieRepository repository;

  GetWatchListStatusSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistSeries(id);
  }
}
