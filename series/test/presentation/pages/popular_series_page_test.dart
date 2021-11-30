import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/bloc/popular/popular_series_bloc.dart';
import 'package:series/presentation/pages/popular_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularSeriesBloc
    extends MockBloc<PopularSeriesEvent, PopularSeriesState>
    implements PopularSeriesBloc {}

class MockPopularSeriesState extends Fake implements PopularSeriesState {}

class MockPopularSeriesEvent extends Fake implements PopularSeriesEvent {}

void main() {
  late MockPopularSeriesBloc mockPopularSeriesBloc;

  setUp(() {
    mockPopularSeriesBloc = MockPopularSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBloc>(
      create: (create) => mockPopularSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(psLoading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page series should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(psHasData);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(psError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
