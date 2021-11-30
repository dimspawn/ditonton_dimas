import 'package:core/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:season/domain/usecases/get_season_detail.dart';

@GenerateMocks([
  MovieRepository,
  GetSeasonDetail,
])
void main() {}
