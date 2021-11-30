// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:core/utils/utils.dart';
import 'package:core/widgets/serie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/watchlist/watchlist_series_bloc.dart';

class WatchlistSeriesPage extends StatefulWidget {
  @override
  _WatchlistSeriesPage createState() => _WatchlistSeriesPage();
}

class _WatchlistSeriesPage extends State<WatchlistSeriesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        // () => Provider.of<WatchlistSeriesNotifier>(context, listen: false)
        //     .fetchWatchlistSeries(),
        () {
      context
          .read<WatchlistSeriesBloc>()
          .add(const InitiateWatchlistSeriesEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // Provider.of<WatchlistSeriesNotifier>(context, listen: false)
    //     .fetchWatchlistSeries();
    context
        .read<WatchlistSeriesBloc>()
        .add(const InitiateWatchlistSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Series Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
          builder: (context, state) {
            if (state is WatchlistSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.watchlistSeries[index];
                  return SeriesCard(serie);
                },
                itemCount: state.watchlistSeries.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
