import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/player_controller.dart';

class PlayerImage extends GetView<PlayerController> {
  const PlayerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: QueryArtworkWidget(
          id: controller.currentSong!.id,
          type: ArtworkType.AUDIO,
          artworkBorder: BorderRadius.circular(14),
          artworkWidth: 220,
          artworkHeight: 220,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: Container(
            width: 220,
            height: 220,
            child: const Center(
              child: Icon(
                Icons.music_note_outlined,
                size: 32,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
