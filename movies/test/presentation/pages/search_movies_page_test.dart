import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/search/search_movies_bloc.dart';
import 'package:movies/presentation/pages/search_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMoviesBloc
    extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}

class MockSearchMoviesState extends Fake implements SearchMoviesEvent {}

class MockSearchMoviesEvent extends Fake implements SearchMoviesState {}

void main() {
  late MockSearchMoviesBloc mockSearchMoviesBloc;

  setUp(() {
    mockSearchMoviesBloc = MockSearchMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchMoviesBloc>(
      create: (context) => mockSearchMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page series should display progress bar when user typing',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state).thenReturn(smLoading);

    final progressFinder = find.byType(CircularProgressIndicator);

    final textFieldFinder = find.byType(TextField);
    final centerFinder = find.byKey(const Key('center_widget'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(textFieldFinder, findsOneWidget);

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page series should display when user done typeing',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.stream)
        .thenAnswer((_) => Stream.value(smHasData));
    when(() => mockSearchMoviesBloc.state).thenReturn(smEmpty);

    final listViewFinder = find.byType(ListView);
    final textFieldFinder = find.byType(TextField);
    final containerFinder = find.byType(Container);

    expect(listViewFinder, findsNothing);
    expect(containerFinder, findsOneWidget);

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'hero');
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page series should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state).thenReturn(smError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Failed to Search Movies'), findsOneWidget);
  });
}
