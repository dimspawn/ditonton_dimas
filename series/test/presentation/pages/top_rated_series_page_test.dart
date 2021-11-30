import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/bloc/top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedSeriesBloc
    extends MockBloc<TopRatedSeriesEvent, TopRatedSeriesState>
    implements TopRatedSeriesBloc {}

class MockTopRatedSeriesState extends Fake implements TopRatedSeriesState {}

class MockTopRatedSeriesEvent extends Fake implements TopRatedSeriesState {}

void main() {
  late MockTopRatedSeriesBloc mockTopRatedSeriesBloc;

  setUp(() {
    mockTopRatedSeriesBloc = MockTopRatedSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBloc>(
      create: (context) => mockTopRatedSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state).thenReturn(trsLoading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page series should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state).thenReturn(trsHasData);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state).thenReturn(trsError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
