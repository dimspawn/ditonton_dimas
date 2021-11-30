import 'package:bloc_test/bloc_test.dart';
import 'package:core/widgets/serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/watchlist/watchlist_series_bloc.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistSeriesBloc
    extends MockBloc<WatchlistSeriesEvent, WatchlistSeriesState>
    implements WatchlistSeriesBloc {}

class MockWatchlistSeriesState extends Fake implements WatchlistSeriesState {}

class MockWatchlistSeriesEvent extends Fake implements WatchlistSeriesEvent {}

void main() {
  late MockWatchlistSeriesBloc mockWatchlistSeriesBloc;

  setUp(() {
    mockWatchlistSeriesBloc = MockWatchlistSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<WatchlistSeriesBloc>(
            create: (context) => mockWatchlistSeriesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.state).thenReturn(wsLoading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page series should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.stream)
        .thenAnswer((_) => Stream.value(wsHasData));
    when(() => mockWatchlistSeriesBloc.state).thenReturn(wsHasData);

    final listViewFinder = find.byType(ListView);
    final seriesCardFinder = find.byType(SeriesCard);

    await tester.pumpWidget(_makeTestableWidget(WatchlistSeriesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(seriesCardFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.state).thenReturn(wsError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
