import 'package:core/domain/repositories/movie_repository.dart';

class GetWatchlistStatusMovies {
  final MovieRepository repository;

  GetWatchlistStatusMovies(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
