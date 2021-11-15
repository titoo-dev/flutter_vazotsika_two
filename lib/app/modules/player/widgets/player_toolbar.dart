import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';

class PlayerToolbar extends GetView<PlayerController> {
  const PlayerToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => controller.back(),
              icon: const Icon(
                Icons.arrow_back_outlined,
              )),
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.more_horiz_outlined)),
        ],
      ),
    );
  }
}
