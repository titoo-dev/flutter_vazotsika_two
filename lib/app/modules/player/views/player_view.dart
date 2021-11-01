import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';
import '../widgets/player_control.dart';
import '../widgets/player_diffusion_control.dart';
import '../widgets/player_image.dart';
import '../widgets/player_info.dart';
import '../widgets/player_seekbar.dart';
import '../widgets/player_toolbar.dart';

class PlayerView extends GetView<PlayerController> {
  const PlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: const [
          PlayerToolbar(),
          PlayerImage(),
          PlayerInfo(),
          SizedBox(height: 14),
          PlayerDiffusionControl(),
          SizedBox(height: 4),
          PlayerSeekbar(),
          SizedBox(height: 14),
          PlayerControl()
        ],
      ),
    ));
  }
}
