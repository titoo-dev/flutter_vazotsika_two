import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/modules/player/controllers/player_controller.dart';
import 'package:get/get.dart';

class PlayerControl extends StatelessWidget {
  const PlayerControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.shuffle_rounded)),
          const Spacer(),
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.skip_previous_outlined)),
          const SizedBox(width: 4),
          PlayPauseButton(),
          const SizedBox(width: 4),
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.skip_next_outlined)),
          const Spacer(),
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.library_music_outlined)),
        ],
      ),
    );
  }
}

class PlayPauseButton extends GetView<PlayerController> {
  const PlayPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.black87,
      padding: const EdgeInsets.all(20),
      // padding: EdgeInsets.zero,
      shape: const CircleBorder(),
      onPressed: () => controller.togglePlayPause(),
      child: StreamBuilder<bool>(
          stream: controller.playerService.player.playingStream,
          builder: (context, snapshot) {
            return AnimatedIcon(
              progress: controller.playingStateAnimation,
              icon: AnimatedIcons.pause_play,
              size: 32,
              color: Colors.white,
            );
          }),
    );
  }
}
