import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class StreamingView extends GetView<HomeController> {
  const StreamingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () => controller.connectToServer(),
          height: 100,
          minWidth: 200,
          color: Theme.of(context).primaryColor,
          child: const Text("Connect"),
        ),
        const SizedBox(height: 20),
        MaterialButton(
          onPressed: () => controller.requestCurrentStreaming(),
          height: 100,
          minWidth: 200,
          color: Theme.of(context).primaryColor,
          child: const Text("Listen"),
        ),
        const SizedBox(height: 20),
        MaterialButton(
          onPressed: () => controller.playDiffusion(),
          height: 100,
          minWidth: 200,
          color: Theme.of(context).primaryColor,
          child: const Text("Play"),
        ),
      ],
    );
  }
}
