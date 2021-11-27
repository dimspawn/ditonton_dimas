// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/constants.dart';

class SeasonCard extends StatelessWidget {
  final int id;
  final Season season;

  const SeasonCard({required this.id, required this.season});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: '$baseImageUrl${season.posterPath}',
                  width: 120,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      season.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(season.overview),
            InkWell(
              onTap: () => Navigator.pushNamed(context, seasonDetailRoute,
                  arguments: {"id": id, "seasonNumber": season.seasonNumber}),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('See Episodes'),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
