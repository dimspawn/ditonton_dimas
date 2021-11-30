import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:season/presentation/bloc/list/season_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SeasonDetailBloc seasonDetailBloc;
  late MockGetSeasonDetail mockGetSeasonDetail;

  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();

    seasonDetailBloc = SeasonDetailBloc(getSeasonDetail: mockGetSeasonDetail);
  });

  group('Season Detail Series', () {
    test('initial state should be empty', () {
      expect(
        seasonDetailBloc.state,
        SeasonDetailEmpty(testSeasonDetail, ''),
      );
    });

    const mockId = 1;
    const mockSeasonNumber = 1;

    blocTest<SeasonDetailBloc, SeasonDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetSeasonDetail.execute(
          mockId,
          mockSeasonNumber,
        )).thenAnswer((_) async => const Right(testSeasonDetail));

        return seasonDetailBloc;
      },
      act: (bloc) => bloc.add(InitiateSeasonDetail(
        id: mockId,
        seasonNumber: mockSeasonNumber,
      )),
      expect: () => [
        SeasonDetailLoading(testSeasonDetail, ''),
        SeasonDetailHasData(testSeasonDetail, '')
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetail.execute(mockId, mockSeasonNumber));
      },
    );

    blocTest<SeasonDetailBloc, SeasonDetailState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetSeasonDetail.execute(mockId, mockSeasonNumber)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return seasonDetailBloc;
      },
      act: (bloc) => bloc.add(
        InitiateSeasonDetail(id: mockId, seasonNumber: mockSeasonNumber),
      ),
      expect: () => [
        SeasonDetailLoading(testSeasonDetail, ''),
        SeasonDetailError(testSeasonDetail, 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetail.execute(mockId, mockSeasonNumber));
      },
    );
  });
}
