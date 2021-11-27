part of 'series_detail_bloc.dart';

abstract class SeriesDetailState extends Equatable {
  const SeriesDetailState();
  @override
  List<Object?> get props => [];
}

class SeriesDetailEmpty extends SeriesDetailState {}

class SeriesDetailLoading extends SeriesDetailState {}

class SeriesDetailError extends SeriesDetailState {
  final String message;
  const SeriesDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class SeriesDetailHasData extends SeriesDetailState {
  final SeriesDetail result;
  final List<Serie> recommendations;
  final bool isWatchlist;
  final String message;
  const SeriesDetailHasData({
    required this.result,
    required this.recommendations,
    required this.isWatchlist,
    required this.message,
  });
  @override
  List<Object?> get props => [
        result,
        recommendations,
        isWatchlist,
      ];
}

// class SeriesWatchlistStatus extends SeriesDetailState {
//   final bool isSave;
//   const SeriesWatchlistStatus(this.isSave);
//   @override
//   List<Object?> get props => [isSave];
// }

// class SeriesWatchlistMessage extends SeriesDetailState {
//   final String message;
//   const SeriesWatchlistMessage(this.message);
//   @override
//   List<Object?> get props => [message];
// }
