import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/home_controller.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 6, right: 6),
      child: Column(
        children: const [LibraryToolbar(), LibraryActions(), LibrarySongList()],
      ),
    );
  }
}

class LibrarySongListTile extends GetView<HomeController> {
  final SongModel songInfo;

  const LibrarySongListTile({Key? key, required this.songInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProcessingState>(
        stream: controller.playerService.player.processingStateStream,
        builder: (context, snapshot) {
          return GetBuilder<PlayerService>(
              id: 'library_list_tile',
              builder: (state) {
                return ListTile(
                  tileColor: snapshot.data == ProcessingState.ready &&
                          controller.currentSong!.id == songInfo.id
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  onTap: () => controller.playAudio(audio: songInfo),
                  title: Text(songInfo.title, overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    songInfo.artist!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.more_vert_outlined),
                );
              });
        });
  }
}

class LibrarySongList extends GetView<HomeController> {
  const LibrarySongList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GetX<HomeController>(builder: (_) {
      if (!_.isLoadingSong.value) {
        final songs = _.songs;
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, i) => const Divider(height: 0),
            padding: EdgeInsets.zero,
            itemCount: songs.length,
            itemBuilder: (_, i) => LibrarySongListTile(songInfo: songs[i]));
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}

class LibraryToolbar extends StatelessWidget {
  const LibraryToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child:
              Text("All Music", style: Theme.of(context).textTheme.headline6),
        ),
        const Spacer(),
        IconButton(
            onPressed: () => {}, icon: const Icon(Icons.search_outlined)),
        IconButton(
            onPressed: () => {}, icon: const Icon(Icons.more_horiz_outlined))
      ],
    );
  }
}

class LibraryActions extends StatelessWidget {
  const LibraryActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => {},
            icon: Icon(Icons.play_circle_fill_outlined,
                color: Theme.of(context).primaryColor),
            label: const Text("Play All (295)"),
          ),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.list))
        ],
      ),
    );
  }
}
