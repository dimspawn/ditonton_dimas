// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:season/presentation/provider/season_detail_notifier.dart';

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
    Future.microtask(() =>
        Provider.of<SeasonDetailNotifier>(context, listen: false)
            .fetchSeasonDetail(widget.id, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SeasonDetailNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                  itemCount: data.seasonDetail.episodes.length,
                  itemBuilder: (contex, index) {
                    return EpisodeCard(
                        episode: data.seasonDetail.episodes[index]);
                  });
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
