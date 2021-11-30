import 'package:bloc_test/bloc_test.dart';
import 'package:core/widgets/season_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';
import 'package:series/presentation/pages/series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeriesDetailBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}

class MockSeriesDetailState extends Fake implements SeriesDetailState {}

class MockSeriesDetailEvent extends Fake implements SeriesDetailEvent {}

void main() {
  late MockSeriesDetailBloc seriesDetailBloc;

  setUp(() {
    seriesDetailBloc = MockSeriesDetailBloc();
  });

  group('Series Detail Test', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SeriesDetailBloc>(
        create: (context) => seriesDetailBloc,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets(
        'Watchlist button should display add icon when serie not added to wathclist',
        (WidgetTester tester) async {
      when(() => seriesDetailBloc.state).thenReturn(sdHasData);

      final watchlistButtonIcon = find.byIcon(Icons.add);
      final seasonCard = find.byType(SeasonCard);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(seasonCard, findsOneWidget);
      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when serie is added to wathclist',
        (WidgetTester tester) async {
      when(() => seriesDetailBloc.state).thenReturn(sdHasDataWatchlisted);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist series',
        (WidgetTester tester) async {
      when(() => seriesDetailBloc.stream)
          .thenAnswer((_) => Stream.value(sdHasDataSuccessAddedData));
      when(() => seriesDetailBloc.state).thenReturn(sdHasDataSuccessAddedData);

      final addWatchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(addWatchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Series Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when removed to watchlist series',
        (WidgetTester tester) async {
      when(() => seriesDetailBloc.stream)
          .thenAnswer((_) => Stream.value(sdHasDataSuccessRemovedData));
      when(() => seriesDetailBloc.state)
          .thenReturn(sdHasDataSuccessRemovedData);

      final addWatchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(addWatchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed From Series Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist Series failed',
        (WidgetTester tester) async {
      when(() => seriesDetailBloc.stream)
          .thenAnswer((_) => Stream.value(sdHasDataFailed));
      when(() => seriesDetailBloc.state).thenReturn(sdHasDataFailed);

      final addWatchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(addWatchlistButton);
      await tester.pump(Duration.zero);

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed To Save or Remove Data'), findsOneWidget);
    });

    testWidgets('Series Detail Page Failed to load',
        (WidgetTester tester) async {
      when(() => seriesDetailBloc.state).thenReturn(sdError);

      final textError = find.text('Error To Load Page');

      await tester
          .pumpWidget(_makeTestableWidget(const SeriesDetailPage(id: 1)));

      expect(textError, findsOneWidget);
    });
  });
}
