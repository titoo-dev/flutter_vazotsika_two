import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../service/player_service.dart';
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
        body: Stack(
      children: [
        GetBuilder<PlayerService>(
            id: 'player_color',
            builder: (state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                color: state.paletteGenerator!.dominantColor!.color
                    .withOpacity(0.4),
              );
            }),
        GetBuilder<PlayerService>(
            id: 'player_shadow_color',
            builder: (state) {
              return Positioned(
                top: 40,
                left: 40,
                right: 40,
                child: AnimatedContainer(
                  width: 300,
                  height: 300,
                  duration: const Duration(milliseconds: 700),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 30,
                          spreadRadius: 14,
                          color: state.paletteGenerator!.dominantColor!.color)
                    ],
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
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
        ),
      ],
    ));
  }
}
