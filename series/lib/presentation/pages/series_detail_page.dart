// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/domain/entities/serie_detail.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/season_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/detail/series_detail_bloc.dart';

class SeriesDetailPage extends StatefulWidget {
  final int id;
  const SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesDetailBloc>().add(InitiateDetailSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state is SeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeriesDetailHasDataRecSuccess ||
              state is SeriesDetailHasDataRecFail ||
              state is SeriesDetailAddWatchlist ||
              state is SeriesDetailRemoveWatchlist ||
              state is SeriesDetailWatchlistError) {
            return SafeArea(
              child: DetailContent(
                state.seriesDetail,
                state.seriesList,
                state.isAdded,
              ),
            );
          } else {
            return Center(
              child: Text(state.message),
            );
          }
        },
        listener: (context, state) {
          if (state is SeriesDetailAddWatchlist ||
              state is SeriesDetailRemoveWatchlist) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SeriesDetailWatchlistError) {
            Future.delayed(
              Duration.zero,
              () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeriesDetail serie;
  final List<Serie> recommendations;
  final bool isAddedWatchlistSeries;

  const DetailContent(
    this.serie,
    this.recommendations,
    this.isAddedWatchlistSeries,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${serie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serie.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlistSeries) {
                                  context
                                      .read<SeriesDetailBloc>()
                                      .add(AddWatchlistSeriesEvent(serie));
                                } else {
                                  context
                                      .read<SeriesDetailBloc>()
                                      .add(RemoveWatchlistSeriesEvent(serie));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlistSeries
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(serie.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: serie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${serie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(serie.overview),
                            const SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 16),
                            LimitedBox(
                              maxHeight: 250,
                              child: ListView.builder(
                                itemCount: serie.seasons.length,
                                itemBuilder: (ctx, dex) {
                                  return SeasonCard(
                                    id: serie.id,
                                    season: serie.seasons[dex],
                                  );
                                },
                              ),
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final recSerie = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, serieDetailRoute,
                                            arguments: recSerie.id);
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${recSerie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

String _showGenres(List<Genre> genres) {
  String result = '';
  for (var genre in genres) {
    result += genre.name + ', ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}
