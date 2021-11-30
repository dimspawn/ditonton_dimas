// ignore_for_file: must_be_immutable

part of 'season_detail_bloc.dart';

abstract class SeasonDetailState extends Equatable {
  SeasonDetail seasonDetail;
  String message;
  SeasonDetailState({
    required this.seasonDetail,
    required this.message,
  });
}

class SeasonDetailEmpty extends SeasonDetailState {
  SeasonDetailEmpty(
    SeasonDetail seasonDetail,
    String message,
  ) : super(
          seasonDetail: seasonDetail,
          message: message,
        );
  @override
  List<Object?> get props => [
        seasonDetail,
        message,
      ];
}

class SeasonDetailLoading extends SeasonDetailState {
  SeasonDetailLoading(
    SeasonDetail seasonDetail,
    String message,
  ) : super(
          seasonDetail: seasonDetail,
          message: message,
        );

  @override
  List<Object?> get props => [
        seasonDetail,
        message,
      ];
}

class SeasonDetailError extends SeasonDetailState {
  SeasonDetailError(
    SeasonDetail seasonDetail,
    String message,
  ) : super(
          seasonDetail: seasonDetail,
          message: message,
        );

  @override
  List<Object?> get props => [
        seasonDetail,
        message,
      ];
}

class SeasonDetailHasData extends SeasonDetailState {
  SeasonDetailHasData(
    SeasonDetail seasonDetail,
    String message,
  ) : super(
          seasonDetail: seasonDetail,
          message: message,
        );

  @override
  List<Object?> get props => [
        seasonDetail,
        message,
      ];
}
