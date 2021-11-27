// Mocks generated by Mockito 5.0.16 from annotations
// in series/test/helpers/test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i12;
import 'dart:ui' as _i20;

import 'package:core/domain/entities/movie.dart' as _i14;
import 'package:core/domain/entities/movie_detail.dart' as _i15;
import 'package:core/domain/entities/season_detail.dart' as _i17;
import 'package:core/domain/entities/serie.dart' as _i16;
import 'package:core/domain/entities/serie_detail.dart' as _i10;
import 'package:core/domain/repositories/movie_repository.dart' as _i4;
import 'package:core/utils/failure.dart' as _i13;
import 'package:core/utils/state_enum.dart' as _i19;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:series/domain/usecases/get_on_the_air_series.dart' as _i21;
import 'package:series/domain/usecases/get_popular_series.dart' as _i3;
import 'package:series/domain/usecases/get_serie_detail.dart' as _i5;
import 'package:series/domain/usecases/get_serie_recommendations.dart' as _i6;
import 'package:series/domain/usecases/get_top_rated_series.dart' as _i11;
import 'package:series/domain/usecases/get_watchlist_series.dart' as _i24;
import 'package:series/domain/usecases/get_watchlist_status_series.dart' as _i7;
import 'package:series/domain/usecases/remove_watchlist_series.dart' as _i9;
import 'package:series/domain/usecases/save_watchlist_series.dart' as _i8;
import 'package:series/domain/usecases/search_series.dart' as _i22;
import 'package:series/presentation/provider/popular_series_notifier.dart'
    as _i18;
import 'package:series/presentation/provider/serie_detail_notifier.dart'
    as _i23;
import 'package:series/presentation/provider/top_rated_series_notifier.dart'
    as _i25;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeGetPopularSeries_1 extends _i1.Fake implements _i3.GetPopularSeries {
}

class _FakeMovieRepository_2 extends _i1.Fake implements _i4.MovieRepository {}

class _FakeGetSeriesDetail_3 extends _i1.Fake implements _i5.GetSeriesDetail {}

class _FakeGetSeriesRecommendations_4 extends _i1.Fake
    implements _i6.GetSeriesRecommendations {}

class _FakeGetWatchListStatusSeries_5 extends _i1.Fake
    implements _i7.GetWatchListStatusSeries {}

class _FakeSaveWatchlistSeries_6 extends _i1.Fake
    implements _i8.SaveWatchlistSeries {}

class _FakeRemoveWatchlistSeries_7 extends _i1.Fake
    implements _i9.RemoveWatchlistSeries {}

class _FakeSeriesDetail_8 extends _i1.Fake implements _i10.SeriesDetail {}

class _FakeGetTopRatedSeries_9 extends _i1.Fake
    implements _i11.GetTopRatedSeries {}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i4.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>
      getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i14.Movie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i14.Movie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i14.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i14.Movie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i14.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i14.Movie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, _i15.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i13.Failure, _i15.MovieDetail>>.value(
              _FakeEither_0<_i13.Failure, _i15.MovieDetail>())) as _i12
          .Future<_i2.Either<_i13.Failure, _i15.MovieDetail>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i14.Movie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i14.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i14.Movie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i14.Movie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, String>> saveWatchlist(
          _i15.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i13.Failure, String>>.value(
                  _FakeEither_0<_i13.Failure, String>()))
          as _i12.Future<_i2.Either<_i13.Failure, String>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, String>> removeWathclist(
          _i15.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWathclist, [movie]),
              returnValue: Future<_i2.Either<_i13.Failure, String>>.value(
                  _FakeEither_0<_i13.Failure, String>()))
          as _i12.Future<_i2.Either<_i13.Failure, String>>);
  @override
  _i12.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i12.Future<bool>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>
      getWatchlistSeries() => (super.noSuchMethod(
          Invocation.method(#getWatchlistSeries, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> getOnTheAirSeries() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirSeries, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> getPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularSeries, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> getTopRatedSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedSeries, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, _i10.SeriesDetail>> getSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i13.Failure, _i10.SeriesDetail>>.value(
                      _FakeEither_0<_i13.Failure, _i10.SeriesDetail>()))
          as _i12.Future<_i2.Either<_i13.Failure, _i10.SeriesDetail>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>
      getSeriesRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getSeriesRecommendations, [id]),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> searchSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchSeries, [query]),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, String>> saveWatchlistSeries(
          _i10.SeriesDetail? series) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistSeries, [series]),
              returnValue: Future<_i2.Either<_i13.Failure, String>>.value(
                  _FakeEither_0<_i13.Failure, String>()))
          as _i12.Future<_i2.Either<_i13.Failure, String>>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, String>> removeWathclistSeries(
          _i10.SeriesDetail? series) =>
      (super.noSuchMethod(Invocation.method(#removeWathclistSeries, [series]),
              returnValue: Future<_i2.Either<_i13.Failure, String>>.value(
                  _FakeEither_0<_i13.Failure, String>()))
          as _i12.Future<_i2.Either<_i13.Failure, String>>);
  @override
  _i12.Future<bool> isAddedToWatchlistSeries(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlistSeries, [id]),
          returnValue: Future<bool>.value(false)) as _i12.Future<bool>);
  @override
  _i12.Future<_i2.Either<_i13.Failure, _i17.SeasonDetail>> getSeasonDetail(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(#getSeasonDetail, [id, seasonNumber]),
              returnValue:
                  Future<_i2.Either<_i13.Failure, _i17.SeasonDetail>>.value(
                      _FakeEither_0<_i13.Failure, _i17.SeasonDetail>()))
          as _i12.Future<_i2.Either<_i13.Failure, _i17.SeasonDetail>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [PopularSeriesNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularSeriesNotifier extends _i1.Mock
    implements _i18.PopularSeriesNotifier {
  MockPopularSeriesNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.GetPopularSeries get getPopularSeries =>
      (super.noSuchMethod(Invocation.getter(#getPopularSeries),
          returnValue: _FakeGetPopularSeries_1()) as _i3.GetPopularSeries);
  @override
  _i19.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i19.RequestState.empty) as _i19.RequestState);
  @override
  List<_i16.Serie> get series => (super.noSuchMethod(Invocation.getter(#series),
      returnValue: <_i16.Serie>[]) as List<_i16.Serie>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchPopularSeries() => (super.noSuchMethod(
      Invocation.method(#fetchPopularSeries, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i20.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i20.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetOnTheAirSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOnTheAirSeries extends _i1.Mock implements _i21.GetOnTheAirSeries {
  MockGetOnTheAirSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetPopularSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularSeries extends _i1.Mock implements _i3.GetPopularSeries {
  MockGetPopularSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetTopRatedSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedSeries extends _i1.Mock implements _i11.GetTopRatedSeries {
  MockGetTopRatedSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SearchSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchSeries extends _i1.Mock implements _i22.SearchSeries {
  MockSearchSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> execute(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SeriesDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesDetailNotifier extends _i1.Mock
    implements _i23.SeriesDetailNotifier {
  MockSeriesDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.GetSeriesDetail get getSeriesDetail =>
      (super.noSuchMethod(Invocation.getter(#getSeriesDetail),
          returnValue: _FakeGetSeriesDetail_3()) as _i5.GetSeriesDetail);
  @override
  _i6.GetSeriesRecommendations get getSeriesRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getSeriesRecommendations),
              returnValue: _FakeGetSeriesRecommendations_4())
          as _i6.GetSeriesRecommendations);
  @override
  _i7.GetWatchListStatusSeries get getWatchListStatusSeries =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatusSeries),
              returnValue: _FakeGetWatchListStatusSeries_5())
          as _i7.GetWatchListStatusSeries);
  @override
  _i8.SaveWatchlistSeries get saveWatchlistSeries => (super.noSuchMethod(
      Invocation.getter(#saveWatchlistSeries),
      returnValue: _FakeSaveWatchlistSeries_6()) as _i8.SaveWatchlistSeries);
  @override
  _i9.RemoveWatchlistSeries get removeWatchlistSeries =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlistSeries),
              returnValue: _FakeRemoveWatchlistSeries_7())
          as _i9.RemoveWatchlistSeries);
  @override
  _i10.SeriesDetail get serie => (super.noSuchMethod(Invocation.getter(#serie),
      returnValue: _FakeSeriesDetail_8()) as _i10.SeriesDetail);
  @override
  _i19.RequestState get serieState =>
      (super.noSuchMethod(Invocation.getter(#serieState),
          returnValue: _i19.RequestState.empty) as _i19.RequestState);
  @override
  List<_i16.Serie> get movieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#movieRecommendations),
          returnValue: <_i16.Serie>[]) as List<_i16.Serie>);
  @override
  _i19.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i19.RequestState.empty) as _i19.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlistSeries =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlistSeries),
          returnValue: false) as bool);
  @override
  String get watchlistMessageSeries =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessageSeries),
          returnValue: '') as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchSeriesDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchSeriesDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  _i12.Future<void> addWatchlistSeries(_i10.SeriesDetail? serie) =>
      (super.noSuchMethod(Invocation.method(#addWatchlistSeries, [serie]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> removeFromWatchlistSeries(_i10.SeriesDetail? serie) =>
      (super.noSuchMethod(
              Invocation.method(#removeFromWatchlistSeries, [serie]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> loadWatchlistSeriesStatus(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistSeriesStatus, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i20.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i20.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesDetail extends _i1.Mock implements _i5.GetSeriesDetail {
  MockGetSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, _i10.SeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<_i2.Either<_i13.Failure, _i10.SeriesDetail>>.value(
                      _FakeEither_0<_i13.Failure, _i10.SeriesDetail>()))
          as _i12.Future<_i2.Either<_i13.Failure, _i10.SeriesDetail>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesRecommendations extends _i1.Mock
    implements _i6.GetSeriesRecommendations {
  MockGetSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchListStatusSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusSeries extends _i1.Mock
    implements _i7.GetWatchListStatusSeries {
  MockGetWatchListStatusSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i12.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistSeries extends _i1.Mock
    implements _i24.GetWatchlistSeries {
  MockGetWatchlistSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, List<_i16.Serie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>.value(
              _FakeEither_0<_i13.Failure, List<_i16.Serie>>())) as _i12
          .Future<_i2.Either<_i13.Failure, List<_i16.Serie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistSeries extends _i1.Mock
    implements _i8.SaveWatchlistSeries {
  MockSaveWatchlistSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, String>> execute(
          _i10.SeriesDetail? serie) =>
      (super.noSuchMethod(Invocation.method(#execute, [serie]),
              returnValue: Future<_i2.Either<_i13.Failure, String>>.value(
                  _FakeEither_0<_i13.Failure, String>()))
          as _i12.Future<_i2.Either<_i13.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistSeries extends _i1.Mock
    implements _i9.RemoveWatchlistSeries {
  MockRemoveWatchlistSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_2()) as _i4.MovieRepository);
  @override
  _i12.Future<_i2.Either<_i13.Failure, String>> execute(
          _i10.SeriesDetail? serie) =>
      (super.noSuchMethod(Invocation.method(#execute, [serie]),
              returnValue: Future<_i2.Either<_i13.Failure, String>>.value(
                  _FakeEither_0<_i13.Failure, String>()))
          as _i12.Future<_i2.Either<_i13.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TopRatedSeriesNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedSeriesNotifier extends _i1.Mock
    implements _i25.TopRatedSeriesNotifier {
  MockTopRatedSeriesNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.GetTopRatedSeries get getTopRatedSeries =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedSeries),
          returnValue: _FakeGetTopRatedSeries_9()) as _i11.GetTopRatedSeries);
  @override
  _i19.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i19.RequestState.empty) as _i19.RequestState);
  @override
  List<_i16.Serie> get series => (super.noSuchMethod(Invocation.getter(#series),
      returnValue: <_i16.Serie>[]) as List<_i16.Serie>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchTopRatedSeries() => (super.noSuchMethod(
      Invocation.method(#fetchTopRatedSeries, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i20.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i20.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}