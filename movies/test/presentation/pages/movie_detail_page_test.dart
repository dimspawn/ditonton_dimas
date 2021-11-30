import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/detail/movies_detail_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviesDetailBloc extends MockBloc<MovieDetailEvent, MoviesDetailState>
    implements MoviesDetailBloc {}

class MockMoviesDetailState extends Fake implements MoviesDetailState {}

class MockMoviesDetailEvent extends Fake implements MovieDetailEvent {}

void main() {
  late MockMoviesDetailBloc mockMoviesDetailBloc;

  setUp(() {
    mockMoviesDetailBloc = MockMoviesDetailBloc();
  });

  group('Movies Detail Test', () {
    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<MoviesDetailBloc>(
        create: (context) => mockMoviesDetailBloc,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets(
        'Watchlist button should display add icon when movie not added to wathclist',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(mdHasData);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(mdHasDataWatchlisted);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist movies',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.stream)
          .thenAnswer((_) => Stream.value(mdHasDataSuccessAddedData));
      when(() => mockMoviesDetailBloc.state)
          .thenReturn(mdHasDataSuccessAddedData);

      final addWatchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(addWatchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Movies Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when Removed From watchlist',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.stream)
          .thenAnswer((_) => Stream.value(mdHasDataSuccessRemovedData));
      when(() => mockMoviesDetailBloc.state)
          .thenReturn(mdHasDataSuccessRemovedData);

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed From Movies Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.stream)
          .thenAnswer((_) => Stream.value(mdHasDataFailed));
      when(() => mockMoviesDetailBloc.state).thenReturn(mdHasDataFailed);

      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump(Duration.zero);

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed To Save or Remove Data'), findsOneWidget);
    });

    testWidgets('Movie Detail Page Fail To load', (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(mdError);

      final errorText = find.text('Movie Detail Page Fail to Load');

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(errorText, findsOneWidget);
    });

    testWidgets('Movie Detail Duration under 60', (WidgetTester tester) async {
      when(() => mockMoviesDetailBloc.state).thenReturn(mdHasDataTime60);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });
  });
}
