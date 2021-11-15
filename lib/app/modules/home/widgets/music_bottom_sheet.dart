import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../controllers/home_controller.dart';
import 'mini_track.dart';

class MusicBottomSheet extends GetView<HomeController> {
  const MusicBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProcessingState>(
      stream: controller.playerService.player.processingStateStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == ProcessingState.ready &&
              controller.getClientStatus() == false) {
            return BottomSheet(
              enableDrag: true,
              constraints: BoxConstraints(minHeight: 60, maxHeight: Get.height),
              animationController: controller.bottomSheetAnimation,
              onClosing: () => {},
              builder: (_) => const MiniTrack(),
            );
          }
          return const SizedBox(height: 0);
        }
        return Container();
      },
    );
  }
}
