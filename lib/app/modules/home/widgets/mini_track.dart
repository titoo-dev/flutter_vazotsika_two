import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/home_controller.dart';

class MiniTrack extends GetView<HomeController> {
  const MiniTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.toPlayerPage(),
            child: QueryArtworkWidget(
              id: controller.currentSong!.id,
              type: ArtworkType.AUDIO,
              artworkBorder: BorderRadius.zero,
              artworkHeight: 60,
              artworkWidth: 60,
              artworkFit: BoxFit.cover,
              nullArtworkWidget: Container(
                decoration: const BoxDecoration(
                  color: Colors.black87,
                ),
                width: 60,
                height: 60,
                child: const Center(
                  child: Icon(
                    Icons.music_note_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GestureDetector(
                  onTap: () => controller.toPlayerPage(),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(controller.currentSong!.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 16)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(controller.currentSong!.artist!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ])),
          SizedBox(
            width: 60,
            child: Center(
              child: StreamBuilder<bool>(
                  stream: controller.playerService.player.playingStream,
                  builder: (context, snapshot) {
                    return IconButton(
                        onPressed: () => controller.togglePlayPause(),
                        icon: AnimatedIcon(
                          progress: controller.playingStateAnimation,
                          icon: AnimatedIcons.pause_play,
                        ));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
