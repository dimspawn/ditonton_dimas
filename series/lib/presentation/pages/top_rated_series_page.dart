// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/widgets/serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/top_rated/top_rated_series_bloc.dart';

class TopRatedSeriesPage extends StatefulWidget {
  @override
  _TopRatedSeriesPage createState() => _TopRatedSeriesPage();
}

class _TopRatedSeriesPage extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        // () => Provider.of<TopRatedSeriesNotifier>(context, listen: false)
        //     .fetchTopRatedSeries(),
        () {
      context
          .read<TopRatedSeriesBloc>()
          .add(const InitiateTopRatedSeriesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state is TopRatedSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.topRatedSeries[index];
                  return SeriesCard(serie);
                },
                itemCount: state.topRatedSeries.length,
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
