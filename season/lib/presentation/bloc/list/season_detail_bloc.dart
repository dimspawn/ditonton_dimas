import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:season/domain/usecases/get_season_detail.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail getSeasonDetail;

  late SeasonDetail _seasonDetail;
  String _message = '';

  SeasonDetailBloc({
    required this.getSeasonDetail,
  }) : super(
          SeasonDetailEmpty(
            const SeasonDetail(
              airDate: 'airDate',
              episodes: [
                Episode(
                  airDate: 'airDate',
                  episodeNumber: 1,
                  id: 1,
                  name: 'name',
                  overview: 'overview',
                  stillPath: 'stillPath',
                ),
              ],
              name: 'name',
              overview: 'overview',
              id: 1,
              posterPath: 'posterPath',
            ),
            '',
          ),
        ) {
    on<InitiateSeasonDetail>(
      (event, emit) async {
        emit(
          SeasonDetailLoading(
            state.seasonDetail,
            state.message,
          ),
        );
        final id = event.id;
        final seasonNumber = event.seasonNumber;
        final seasonResult = await getSeasonDetail.execute(id, seasonNumber);

        seasonResult.fold(
          (failure) {
            _message = failure.message;
            emit(SeasonDetailError(
              state.seasonDetail,
              _message,
            ));
          },
          (data) {
            _seasonDetail = data;
            emit(
              SeasonDetailHasData(
                _seasonDetail,
                _message,
              ),
            );
          },
        );
      },
    );
  }
}
