// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/serie.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:series/presentation/bloc/popular/popular_series_bloc.dart';
import 'package:series/presentation/bloc/top_rated/top_rated_series_bloc.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:movies/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movies_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // Provider.of<MovieListNotifier>(context, listen: false)
      //   ..fetchNowPlayingMovies()
      //   ..fetchPopularMovies()
      //   ..fetchTopRatedMovies();
      // Provider.of<SeriesListNotifier>(context, listen: false)
      //   ..fetchOnTheAirSeries()
      //   ..fetchPopularSeries()
      //   ..fetchTopRatedSeries();
      context
          .read<NowPlayingMoviesBloc>()
          .add(const InitiateNowPlayingMoviesEvent());
      context.read<PopularMoviesBloc>().add(const InitiatePopularMoviesEvent());
      context
          .read<TopRatedMoviesBloc>()
          .add(const InitiateTopRatedMoviesEvent());
      context
          .read<OnTheAirSeriesBloc>()
          .add(const InitiateOnTheAirSeriesEvent());
      context.read<PopularSeriesBloc>().add(const InitiatePopularSeriesEvent());
      context
          .read<TopRatedSeriesBloc>()
          .add(const InitiateTopRatedSeriesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Movies Watchlist'),
              onTap: () => Navigator.pushNamed(context, watchlistMovieRoute),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Series Watchlist'),
              onTap: () => Navigator.pushNamed(context, watchlistSerieRoute),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          PopupMenuButton(
              onSelected: (nValue) {
                if (nValue == 0) {
                  Navigator.pushNamed(context, searchMovieRoute);
                } else if (nValue == 1) {
                  Navigator.pushNamed(context, searchSerieRoute);
                }
              },
              itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      child: Text('Search Movies'),
                      value: 0,
                    ),
                    const PopupMenuItem(
                      child: Text('Search Series'),
                      value: 1,
                    ),
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Movies',
                  style: kHeading5,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                  builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesHasData) {
                  return MovieList(state.nowPlayingMovies);
                } else {
                  return const Text('Failed to Load Now Playing Movies');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularMovieRoute),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  return MovieList(state.popularMovies);
                } else {
                  return const Text('Failed to Load Popular Movies');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedMoviesRoute),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                  builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  return MovieList(state.topRatedMovies);
                } else {
                  return const Text('Failed to Load Top Rated Movies');
                }
              }),
              const SizedBox(height: 25),
              Center(child: Text('Series', style: kHeading5)),
              const SizedBox(height: 25),
              _buildSubHeading(
                title: 'On The Air',
                onTap: () => Navigator.pushNamed(context, onTheAirRoute),
              ),
              BlocBuilder<OnTheAirSeriesBloc, OnTheAirSeriesState>(
                  builder: (context, state) {
                if (state is OnTheAirSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OnTheAirSeriesHasData) {
                  return SeriesList(state.onTheAirSeries);
                } else {
                  return const Center(
                      child: Text('Failed To Load On The Air Series'));
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularSerieRoute),
              ),
              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                  builder: (context, state) {
                if (state is PopularSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularSeriesHasData) {
                  return SeriesList(state.popularSeries);
                } else {
                  return const Center(
                      child: Text('Failed to Load Popular Series'));
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedSeriesRoute),
              ),
              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedSeriesHasData) {
                  return SeriesList(state.topRatedSeries);
                } else {
                  return const Text('Failed To Load Top Series');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text('See More'),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      )
    ],
  );
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Serie> series;

  const SeriesList(this.series);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final serie = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  serieDetailRoute,
                  arguments: serie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${serie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
