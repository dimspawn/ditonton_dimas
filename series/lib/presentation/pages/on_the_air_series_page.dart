// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/widgets/serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:provider/provider.dart';

class OnTheAirSeriesPage extends StatefulWidget {
  @override
  _OnTheAirSeriesPage createState() => _OnTheAirSeriesPage();
}

class _OnTheAirSeriesPage extends State<OnTheAirSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        // () => Provider.of<OnTheAirNotifier>(context, listen: false)
        //     .fetchOnTheAirSeries(),
        () {
      context
          .read<OnTheAirSeriesBloc>()
          .add(const InitiateOnTheAirSeriesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirSeriesBloc, OnTheAirSeriesState>(
          builder: (context, state) {
            if (state is OnTheAirSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.onTheAirSeries[index];
                  return SeriesCard(serie);
                },
                itemCount: state.onTheAirSeries.length,
              );
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
