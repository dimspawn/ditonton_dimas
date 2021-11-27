// import 'package:core/domain/entities/serie.dart';
// import 'package:core/utils/state_enum.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
// import 'package:series/presentation/pages/serie_detail_page.dart';
// import 'package:mockito/mockito.dart';

// import '../../dummy_data/dummy_objects.dart';
// import '../../helpers/test_helpers.mocks.dart';

// void main() {
//   late MockSeriesDetailBloc mockNotifier;

//   setUp(() {
//     mockNotifier = MockSeriesDetailBloc();
//   });

//   Widget _makeTestableWidget(Widget body) {
//     return BlocProvider<SeriesDetailBloc>.value(
//       value: mockNotifier,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   testWidgets(
//       'Watchlist button should display add icon when serie not added to wathclist',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.loaded);
//     when(mockNotifier.getSeriesDetail).thenReturn(testSerieDetail);
//     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
//     when(mockNotifier.movieRecommendations).thenReturn(<Serie>[]);
//     when(mockNotifier.isAddedToWatchlistSeries).thenReturn(false);

//     final watchlistButtonIcon = find.byIcon(Icons.add);

//     await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

//     expect(watchlistButtonIcon, findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should dispay check icon when serie is added to wathclist',
//       (WidgetTester tester) async {
//     when(mockNotifier.serieState).thenReturn(RequestState.loaded);
//     when(mockNotifier.serie).thenReturn(testSerieDetail);
//     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
//     when(mockNotifier.movieRecommendations).thenReturn(<Serie>[]);
//     when(mockNotifier.isAddedToWatchlistSeries).thenReturn(true);

//     final watchlistButtonIcon = find.byIcon(Icons.check);

//     await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

//     expect(watchlistButtonIcon, findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should display Snackbar when added to watchlist series',
//       (WidgetTester tester) async {
//     when(mockNotifier.serieState).thenReturn(RequestState.loaded);
//     when(mockNotifier.serie).thenReturn(testSerieDetail);
//     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
//     when(mockNotifier.movieRecommendations).thenReturn(<Serie>[]);
//     when(mockNotifier.isAddedToWatchlistSeries).thenReturn(false);
//     when(mockNotifier.watchlistMessageSeries)
//         .thenReturn('Added to Series Watchlist');

//     final watchlistButton = find.byType(ElevatedButton);

//     await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

//     expect(find.byIcon(Icons.add), findsOneWidget);

//     await tester.tap(watchlistButton);
//     await tester.pump();

//     expect(find.byType(SnackBar), findsOneWidget);
//     expect(find.text('Added to Series Watchlist'), findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should display AlertDialog when add to watchlist Series failed',
//       (WidgetTester tester) async {
//     when(mockNotifier.serieState).thenReturn(RequestState.loaded);
//     when(mockNotifier.serie).thenReturn(testSerieDetail);
//     when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
//     when(mockNotifier.movieRecommendations).thenReturn(<Serie>[]);
//     when(mockNotifier.isAddedToWatchlistSeries).thenReturn(false);
//     when(mockNotifier.watchlistMessageSeries).thenReturn('Failed');

//     final watchlistButton = find.byType(ElevatedButton);

//     await tester.pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

//     expect(find.byIcon(Icons.add), findsOneWidget);

//     await tester.tap(watchlistButton);
//     await tester.pump();

//     expect(find.byType(AlertDialog), findsOneWidget);
//     expect(find.text('Failed'), findsOneWidget);
//   });
// }
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/domain/usecases/get_serie_detail.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:series/presentation/pages/serie_detail_page.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeriesDetailBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}

class MockSeriesDetailState extends Fake implements SeriesDetailState {}

class MockSeriesDetailEvent extends Fake implements SeriesDetailEvent {}

void main() {
  late MockSeriesDetailBloc seriesDetailBloc;

  setUpAll(() {
    registerFallbackValue(MockSeriesDetailState());
    registerFallbackValue(MockSeriesDetailEvent());
  });
  setUp(() {
    seriesDetailBloc = MockSeriesDetailBloc();
  });
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeriesDetailBloc>.value(
      value: seriesDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Test Widget', (WidgetTester tester) async {
    whenListen(
      seriesDetailBloc,
      Stream.fromIterable(
        [
          SeriesDetailLoading(),
          const SeriesDetailHasData(
            result: testSerieDetail,
            recommendations: [],
            isWatchlist: false,
            message: '',
          )
        ],
      ),
      initialState: SeriesDetailEmpty(),
    );
    // when(() => seriesDetailBloc.stream)
    //     .thenAnswer((_) => Stream.value(SeriesDetailEmpty()));
    // when(() => seriesDetailBloc.get(any()))
    // when(() => seriesDetailBloc).thenAnswer((_) => SeriesDetailLoading());
    // when(() => seriesDetailBloc.getSeriesDetail)
    //     .thenAnswer((_) => testSerieDetail);
    // when(() => tvDetailBloc.tv).thenReturn(testTvDetail);
    // when(() => tvDetailBloc.recommendation).thenAnswer((_) => tTvList);
    // when(() => tvDetailBloc.recommendation).thenReturn(tTvList);
    // when(() => tvDetailBloc.isAddedWatchlist).thenAnswer((_) => false);
    // when(() => tvDetailBloc.isAddedWatchlist).thenReturn(false);
    // when(() => tvDetailBloc.stream)
    //     .thenAnswer((_) => Stream.value(TvDetailLoaded()));
    // when(() => tvDetailBloc.state).thenReturn(TvDetailLoaded());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(
        _makeTestableWidget(const SeriesDetailPage(id: 1))));

    await tester.pumpAndSettle();

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
