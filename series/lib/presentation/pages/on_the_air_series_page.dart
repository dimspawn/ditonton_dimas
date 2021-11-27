// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:series/presentation/provider/on_the_air_notifier.dart';
import 'package:provider/provider.dart';

class OnTheAirSeriesPage extends StatefulWidget {
  @override
  _OnTheAirSeriesPage createState() => _OnTheAirSeriesPage();
}

class _OnTheAirSeriesPage extends State<OnTheAirSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<OnTheAirNotifier>(context, listen: false)
        .fetchOnTheAirSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = data.series[index];
                  return SeriesCard(serie);
                },
                itemCount: data.series.length,
              );
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
