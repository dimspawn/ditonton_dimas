import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/serie_table.dart';
import 'package:core/utils/encrypt.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tbWatchlist = 'watchlist';
  static const String _tblCache = 'cache';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('aspirine'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tbWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
    await db.execute('''
    CREATE TABLE $_tblCache (
      id INTEGER PRIMARY KEY,
      title TEXT,
      overview TEXT,
      posterPath TEXT,
      category TEXT
    )''');
  }

  Future<void> insertCacheTransaction(
      List<MovieTable> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCache, movieJson);
      }
    });
  }

  Future<void> insertCacheTransactionSeries(
      List<SeriesTable> series, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final series in series) {
        final serieJson = series.toJson();
        serieJson['category'] = category;
        txn.insert(_tblCache, serieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheFilm(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tbWatchlist, movie.toJson());
  }

  Future<int> insertWatchlistSeries(SeriesTable serie) async {
    final db = await database;
    return await db!.insert(_tbWatchlist, serie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tbWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeWatchlistSeries(SeriesTable serie) async {
    final db = await database;
    return await db!.delete(
      _tbWatchlist,
      where: 'id = ?',
      whereArgs: [serie.id],
    );
  }

  Future<Map<String, dynamic>?> getFilmById(int id, String category) async {
    final db = await database;
    final results = await db!.query(
      _tbWatchlist,
      where: 'id = ? and category = ?',
      whereArgs: [id, category],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistFilm(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tbWatchlist,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }
}
