// ignore_for_file: must_be_immutable

part of 'season_detail_bloc.dart';

abstract class SeasonDetailEvent {
  const SeasonDetailEvent();
}

class InitiateSeasonDetail extends SeasonDetailEvent {
  int id;
  int seasonNumber;
  InitiateSeasonDetail({
    required this.id,
    required this.seasonNumber,
  });
}
