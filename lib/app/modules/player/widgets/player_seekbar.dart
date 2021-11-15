import 'package:flutter/material.dart';
import '../controllers/player_controller.dart';
import 'package:get/get.dart';

class PlayerSeekbar extends GetView<PlayerController> {
  const PlayerSeekbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        children: [
          StreamBuilder<Duration>(
              initialData: const Duration(seconds: 0),
              stream: controller.playerService.player.positionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final duration = snapshot.data.toString().split(':');
                  return Text(duration[1] + ':' + duration[2].split('.')[0],
                      style: Theme.of(context).textTheme.caption);
                }
                return Text("00:00",
                    style: Theme.of(context).textTheme.caption);
              }),
          Expanded(
            child: StreamBuilder<Duration>(
                initialData: const Duration(seconds: 0),
                stream: controller.playerService.player.positionStream,
                builder: (context, snapshot) {
                  if (controller.playerService.player.duration != null) {
                    return Slider(
                      min: 0,
                      inactiveColor: Colors.black38,
                      thumbColor: Colors.black87,
                      activeColor: Colors.black87,
                      max: controller.playerService.player.duration!.inSeconds
                          .toDouble(),
                      value: snapshot.data!.inSeconds.toDouble(),
                      onChanged: controller.handleSeek,
                    );
                  }
                  return const Slider(
                    min: 0,
                    inactiveColor: Colors.black38,
                    thumbColor: Colors.black87,
                    activeColor: Colors.black87,
                    max: 0,
                    value: 0,
                    onChanged: null,
                  );
                }),
          ),
          StreamBuilder<Duration?>(
              initialData: const Duration(seconds: 0),
              stream: controller.playerService.player.durationStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final duration = snapshot.data.toString().split(':');

                  return Text(duration[1] + ':' + duration[2].split('.')[0],
                      style: Theme.of(context).textTheme.caption);
                }
                return Text("00:00",
                    style: Theme.of(context).textTheme.caption);
              })
        ],
      ),
    );
  }
}
