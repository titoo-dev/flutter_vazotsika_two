import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';

class PlayerInfo extends GetView<PlayerController> {
  const PlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 34, right: 34, top: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(controller.currentSong!.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black)),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => {},
                  icon: const Icon(Icons.favorite_border))
            ],
          ),
          const SizedBox(height: 8),
          Text(controller.currentSong!.artist!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.black87)),
        ],
      ),
    );
  }
}
