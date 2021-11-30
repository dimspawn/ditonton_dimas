import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/bloc/search/search_series_bloc.dart';
import 'package:series/presentation/pages/search_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchSeriesBloc
    extends MockBloc<SearchSeriesEvent, SearchSeriesState>
    implements SearchSeriesBloc {}

class MockSearchSeriesState extends Fake implements SearchSeriesEvent {}

class MockSearchSeriesEvent extends Fake implements SearchSeriesState {}

void main() {
  late MockSearchSeriesBloc mockSearchSeriesBloc;

  setUp(() {
    mockSearchSeriesBloc = MockSearchSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchSeriesBloc>(
      create: (context) => mockSearchSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display progress bar when user typing',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state).thenReturn(ssLoading);

    final progressFinder = find.byType(CircularProgressIndicator);

    final textFieldFinder = find.byType(TextField);
    final centerFinder = find.byKey(const Key('center_widget'));

    await tester.pumpWidget(_makeTestableWidget(SearchSeriesPage()));

    expect(textFieldFinder, findsOneWidget);

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page series should display when user done typeing',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.stream)
        .thenAnswer((_) => Stream.value(ssHasData));
    when(() => mockSearchSeriesBloc.state).thenReturn(ssEmpty);

    final listViewFinder = find.byType(ListView);
    final textFieldFinder = find.byType(TextField);
    final containerFinder = find.byType(Container);

    expect(listViewFinder, findsNothing);
    expect(containerFinder, findsOneWidget);

    await tester.pumpWidget(_makeTestableWidget(SearchSeriesPage()));

    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'hero');
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state).thenReturn(ssError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SearchSeriesPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Failed to Search Series'), findsOneWidget);
  });
}
