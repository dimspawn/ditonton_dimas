// ignore_for_file: must_be_immutable

part of 'series_detail_bloc.dart';

abstract class SeriesDetailState extends Equatable {
  SeriesDetail seriesDetail;
  List<Serie> seriesList;
  bool isAdded;
  String message;
  SeriesDetailState({
    required this.seriesDetail,
    required this.seriesList,
    required this.isAdded,
    required this.message,
  });
}

class SeriesDetailEmpty extends SeriesDetailState {
  SeriesDetailEmpty(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );
  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailLoading extends SeriesDetailState {
  SeriesDetailLoading(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailError extends SeriesDetailState {
  SeriesDetailError(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailHasDataRecSuccess extends SeriesDetailState {
  SeriesDetailHasDataRecSuccess(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailHasDataRecFail extends SeriesDetailState {
  SeriesDetailHasDataRecFail(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailAddWatchlist extends SeriesDetailState {
  SeriesDetailAddWatchlist(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailRemoveWatchlist extends SeriesDetailState {
  SeriesDetailRemoveWatchlist(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}

class SeriesDetailWatchlistError extends SeriesDetailState {
  SeriesDetailWatchlistError(
    SeriesDetail seriesDetail,
    List<Serie> seriesList,
    bool isAdded,
    String message,
  ) : super(
          seriesDetail: seriesDetail,
          seriesList: seriesList,
          isAdded: isAdded,
          message: message,
        );

  @override
  List<Object?> get props => [
        seriesDetail,
        seriesList,
        isAdded,
        message,
      ];
}
