import 'package:core/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:series/domain/usecases/get_on_the_air_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_serie_detail.dart';
import 'package:series/domain/usecases/get_serie_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_status_series.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:series/presentation/provider/popular_series_notifier.dart';
import 'package:series/presentation/provider/serie_detail_notifier.dart';
import 'package:series/presentation/provider/top_rated_series_notifier.dart';

@GenerateMocks([
  MovieRepository,
  PopularSeriesNotifier,
  GetOnTheAirSeries,
  GetPopularSeries,
  GetTopRatedSeries,
  SearchSeries,
  SeriesDetailNotifier,
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListStatusSeries,
  GetWatchlistSeries,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
  TopRatedSeriesNotifier,
])
void main() {}
