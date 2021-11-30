import 'package:bloc_test/bloc_test.dart';
import 'package:core/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:season/presentation/bloc/list/season_detail_bloc.dart';
import 'package:season/presentation/pages/season_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeasonDetailBloc
    extends MockBloc<SeasonDetailEvent, SeasonDetailState>
    implements SeasonDetailBloc {}

class MockSeasonDetailState extends Fake implements SeasonDetailEvent {}

class MockSeasonDetailEvent extends Fake implements SeasonDetailState {}

void main() {
  late MockSeasonDetailBloc mockSeasonDetailBloc;

  setUp(() {
    mockSeasonDetailBloc = MockSeasonDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailBloc>(
      create: (contex) => mockSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailBloc.state).thenReturn(sddLoading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailBloc.state).thenReturn(sddHasData);

    final listViewFinder = find.byType(ListView);
    final episodeCard = find.byType(EpisodeCard);

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(listViewFinder, findsOneWidget);
    expect(episodeCard, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailBloc.state).thenReturn(sddError);

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const SeasonDetailPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(textFinder, findsOneWidget);
  });
}
