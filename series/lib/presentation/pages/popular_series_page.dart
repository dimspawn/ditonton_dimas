// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/widgets/serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/bloc/popular/popular_series_bloc.dart';
import 'package:provider/provider.dart';

class PopularSeriesPage extends StatefulWidget {
  @override
  _PopularSeriesPage createState() => _PopularSeriesPage();
}

class _PopularSeriesPage extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        // () => Provider.of<PopularSeriesNotifier>(context, listen: false)
        //     .fetchPopularSeries(),
        () {
      context.read<PopularSeriesBloc>().add(const InitiatePopularSeriesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (context, state) {
            if (state is PopularSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.popularSeries[index];
                  return SeriesCard(serie);
                },
                itemCount: state.popularSeries.length,
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
