import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/socket_client.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class StreamingView extends GetView<HomeController> {
  const StreamingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<SocketClient>(
            id: 'streaming_image',
            builder: (_) {
              if (controller.playerService.imageBuffer.isNotEmpty) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(Uint8List.fromList(
                              controller.playerService.imageBuffer))),
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                  width: 200,
                  height: 200,
                );
              }
              return Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                width: 200,
                height: 200,
                child: const Center(child: Text("Waiting...")),
              );
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
    );
  }
}
