part of 'series_detail_bloc.dart';

abstract class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();
  @override
  List<Object?> get props => [];
}

class InitiateDetailSeries extends SeriesDetailEvent {
  final int id;
  const InitiateDetailSeries(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistSeriesEvent extends SeriesDetailEvent {
  final SeriesDetail seriesDetail;
  const AddWatchlistSeriesEvent(this.seriesDetail);

  @override
  List<Object?> get props => [seriesDetail];
}

class RemoveWatchlistSeriesEvent extends SeriesDetailEvent {
  final SeriesDetail seriesDetail;
  const RemoveWatchlistSeriesEvent(this.seriesDetail);

  @override
  List<Object?> get props => [seriesDetail];
}
