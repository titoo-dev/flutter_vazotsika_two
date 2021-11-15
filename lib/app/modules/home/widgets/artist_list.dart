import 'package:flutter/material.dart';
import 'artist_tile.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class ArtistList extends GetView<HomeController> {
  const ArtistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: 100,
        child: GetX<HomeController>(
          builder: (_) {
            if (!_.isLoadingArtist.value) {
              final artist = _.artist;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemCount: artist.length,
                itemBuilder: (_, i) => ArtistTile(
                  artistInfo: artist[i],
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, i) => const Padding(
                padding: EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 70,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
