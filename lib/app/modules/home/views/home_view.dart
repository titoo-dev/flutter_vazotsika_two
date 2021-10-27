import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StreamBuilder<ProcessingState>(
          stream: controller.playerService.player.processingStateStream,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data! == ProcessingState.ready
                  ? FloatingActionButton(
                      onPressed: () => controller.togglePlayPause(),
                      child: AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          progress: controller.playingStateAnimation),
                    )
                  : Container();
            }
            return Container();
          }),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: const Text('AudioPlayer'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => controller.playDiffusion(),
              icon: const Icon(Icons.radio))
        ],
      ),
      body: FutureBuilder<List<SongInfo>>(
        future: controller.getAllMusic,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final songs = snapshot.data;
            return ListView.builder(
                itemCount: songs!.length,
                itemBuilder: (_, i) => SonginfoTile(songInfo: songs[i]));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SonginfoTile extends GetView<HomeController> {
  final SongInfo songInfo;

  const SonginfoTile({Key? key, required this.songInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => controller.playAudio(songInfo.filePath),
        title: Text(
          songInfo.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          songInfo.artist,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: ElevatedButton(
            onPressed: () => controller.diffuseSong(songInfo: songInfo),
            child: const Text("Diffuse")),
        leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.music_note_outlined)));
  }
}
