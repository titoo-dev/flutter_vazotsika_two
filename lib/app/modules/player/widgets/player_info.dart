import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';

class PlayerInfo extends GetView<PlayerController> {
  const PlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 34, right: 34, top: 26),
      child: GetBuilder<PlayerService>(
          id: 'player_info',
          builder: (state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(state.currentSong!.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                    ),
                    // GetBuilder<PlayerService>(
                    //     id: 'player_color',
                    //     builder: (state) {
                    //       return Container(
                    //         width: 30,
                    //         height: 30,
                    //         color: state.paletteGenerator!.dominantColor!.color,
                    //       );
                    //     })
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => {},
                        icon: const Icon(Icons.favorite_border))
                  ],
                ),
                const SizedBox(height: 8),
                Text(state.currentSong!.artist!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.black87)),
              ],
            );
          }),
    );
  }
}
