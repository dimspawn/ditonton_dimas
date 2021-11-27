// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/constants.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
      decoration: const BoxDecoration(
        color: kOxfordBlue,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: '$baseImageUrl${episode.stillPath}',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${episode.episodeNumber}. ${episode.name}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(episode.overview),
          ],
        ),
      ),
    );
  }
}
