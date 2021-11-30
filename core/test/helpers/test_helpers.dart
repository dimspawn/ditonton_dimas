import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/utils/connection.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  NetworkInfo,
  Connection,
])
void main() {}
