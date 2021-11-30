import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:series/presentation/pages/on_the_air_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnTheAirSeriesBloc
    extends MockBloc<OnTheAirSeriesEvent, OnTheAirSeriesState>
    implements OnTheAirSeriesBloc {}

class MockOnTheAirSeriesState extends Fake implements OnTheAirSeriesState {}

class MockOnTheAirSeriesEvent extends Fake implements OnTheAirSeriesEvent {}

void main() {
  late MockOnTheAirSeriesBloc mockOnTheAirSeriesBloc;

  setUp(() {
    mockOnTheAirSeriesBloc = MockOnTheAirSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirSeriesBloc>(
      create: (create) => mockOnTheAirSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockOnTheAirSeriesBloc.state).thenReturn(otaLoading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page series should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockOnTheAirSeriesBloc.state).thenReturn(otaHasData);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockOnTheAirSeriesBloc.state).thenReturn(otaError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
