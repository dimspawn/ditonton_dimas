part of 'series_detail_bloc.dart';

abstract class SeriesDetailEvent {
  const SeriesDetailEvent();
}

class InitiateDetailSeries extends SeriesDetailEvent {
  final int id;
  const InitiateDetailSeries(this.id);
}

class AddWatchlistSeriesEvent extends SeriesDetailEvent {
  final SeriesDetail seriesDetail;
  const AddWatchlistSeriesEvent(this.seriesDetail);
}

class RemoveWatchlistSeriesEvent extends SeriesDetailEvent {
  final SeriesDetail seriesDetail;
  const RemoveWatchlistSeriesEvent(this.seriesDetail);
}
