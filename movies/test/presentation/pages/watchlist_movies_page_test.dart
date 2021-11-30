import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/watchlist/watchlist_movies_bloc.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class MockWatchlistMoviesState extends Fake implements WatchlistMoviesBloc {}

class MockWatchlistMoviesEvent extends Fake implements WatchlistMoviesBloc {}

void main() {
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUp(() {
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>(
      create: (context) => mockWatchlistMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(wmLoading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page series should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(wmHasData));
    when(() => mockWatchlistMoviesBloc.state).thenReturn(wmHasData);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(wmError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
