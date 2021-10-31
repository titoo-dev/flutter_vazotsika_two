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
                }),
          ),
          FutureBuilder<Duration?>(
              initialData: const Duration(seconds: 0),
              future: controller.playerService.player.durationFuture,
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
