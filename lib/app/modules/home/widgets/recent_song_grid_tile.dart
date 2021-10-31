import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentSongGridTile extends GetView<HomeController> {
  final SongModel songInfo;

  const RecentSongGridTile({Key? key, required this.songInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () => controller.playAudio(audio: songInfo),
      child: Column(
        children: [
          Expanded(
            child: QueryArtworkWidget(
              artworkWidth: double.infinity,
              artworkBorder: BorderRadius.zero,
              id: songInfo.id,
              type: ArtworkType.AUDIO,
              artworkFit: BoxFit.cover,
              nullArtworkWidget: Container(
                child: const Center(
                  child: Icon(
                    Icons.music_note_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    songInfo.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    songInfo.artist!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.black54),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
