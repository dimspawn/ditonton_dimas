// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:season/presentation/bloc/list/season_detail_bloc.dart';

class SeasonDetailPage extends StatefulWidget {
  final int id;
  final int seasonNumber;
  const SeasonDetailPage({required this.id, required this.seasonNumber});
  @override
  _SeasonDetailPage createState() => _SeasonDetailPage();
}

class _SeasonDetailPage extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SeasonDetailBloc>().add(InitiateSeasonDetail(
          id: widget.id, seasonNumber: widget.seasonNumber)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
          builder: (context, state) {
            if (state is SeasonDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeasonDetailHasData) {
              return ListView.builder(
                  itemCount: state.seasonDetail.episodes.length,
                  itemBuilder: (contex, index) {
                    return EpisodeCard(
                        episode: state.seasonDetail.episodes[index]);
                  });
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}
