import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'sprite_painter.dart';

class NearbyAnimation extends GetView<HomeController> {
  const NearbyAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Center(
        child: CustomPaint(
          painter: SpritePainter(
              controller.nearbyAnimationController, PaintingStyle.stroke),
          child: const SizedBox(
            width: 400,
            height: 400,
          ),
        ),
      ),
    );
  }
}
