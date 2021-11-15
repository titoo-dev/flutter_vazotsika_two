import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:just_audio/just_audio.dart';
import '../widgets/nearby_animation.dart';
import 'package:get/get.dart';

import '../../../service/socket_client.dart';
import '../controllers/home_controller.dart';

class StreamingView extends GetView<HomeController> {
  const StreamingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NearbyAnimation(),

          GetBuilder<SocketClient>(
              id: 'streaming_image',
              builder: (_) {
                if (controller.playerService.imageBuffer.isNotEmpty) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Center(
                      child: Container(
                        child: StreamBuilder<bool>(
                            stream:
                                controller.playerService.player.playingStream,
                            builder: (context, snapshot) {
                              return IconButton(
                                  onPressed: () => controller.playDiffusion(),
                                  icon: AnimatedIcon(
                                    size: 50,
                                    progress: controller.playingStateAnimation,
                                    icon: AnimatedIcons.play_pause,
                                    color: Colors.white,
                                  ));
                              // return const Icon(Icons.play_arrow_outlined,
                              //     size: 50, color: Colors.white);
                            }),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(
                                  Uint8List.fromList(
                                      controller.playerService.imageBuffer),
                                ),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                        width: 200,
                        height: 200,
                      ),
                    ),
                  );
                }
                return SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: GetX<SocketClient>(builder: (state) {
                    // final PlayerService playerService = Get.find();
                    return state.isJoined.value
                        ? Center(
                            child: InkWell(
                              onTap: controller.requestCurrentStreaming,
                              child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber,
                                  ),
                                  child: const Icon(Icons.music_note_outlined)),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Waiting for connection...",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          );
                  }),
                );
              }),

          GetX<SocketClient>(builder: (state) {
            return state.isJoined.value
                ? Positioned(
                    top: 30,
                    right: 20,
                    child: ElevatedButton(
                        onPressed: state.close, child: const Text("Close")))
                : const SizedBox();
          })
          // MaterialButton(
          //   onPressed: () => controller.connectToServer(),
          //   height: 100,
          //   minWidth: 200,
          //   color: Theme.of(context).primaryColor,
          //   child: const Text("Connect"),
          // ),
          // const SizedBox(height: 20),
          // MaterialButton(
          //   onPressed: () => controller.requestCurrentStreaming(),
          //   height: 100,
          //   minWidth: 200,
          //   color: Theme.of(context).primaryColor,
          //   child: const Text("Listen"),
          // ),
          // const SizedBox(height: 20),
          // MaterialButton(
          //   onPressed: () => controller.playDiffusion(),
          //   height: 100,
          //   minWidth: 200,
          //   color: Theme.of(context).primaryColor,
          //   child: const Text("Play"),
          // ),
        ],
      ),
    );
  }
}
