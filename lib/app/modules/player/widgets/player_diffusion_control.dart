import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';

class PlayerDiffusionControl extends StatelessWidget {
  const PlayerDiffusionControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
      id: 'radio_icon',
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _.toggleStreaming(),
                icon: _.isStreaming
                    ? Icon(Icons.radio_rounded,
                        color: Theme.of(context).primaryColor)
                    : const Icon(Icons.radio_rounded, color: Colors.black54),
              ),
              if (_.isStreaming) ...[
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.plumbing),
                  onPressed: () => _.sharePosition(),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
