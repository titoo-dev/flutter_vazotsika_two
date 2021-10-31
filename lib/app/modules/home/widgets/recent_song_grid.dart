import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'recent_song_grid_tile.dart';

class RecentSongGrid extends GetView<HomeController> {
  const RecentSongGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<HomeController>(
        builder: (_) {
          if (!_.isLoadingSong.value) {
            final songs = _.songs;
            return Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 14),
                mainAxisSpacing: 8,
                crossAxisSpacing: 14,
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: List.generate(
                  songs.length,
                  (index) => RecentSongGridTile(
                    songInfo: songs[index],
                  ),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              children: List.generate(
                4,
                (index) => Container(
                  color: Colors.grey[200],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
