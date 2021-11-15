import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:palette_generator/palette_generator.dart';

import '../provider/audio_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerService extends GetxController {
  PaletteGenerator? paletteGenerator;

  final player = AudioPlayer();
  final AudioProvider provider = Get.find();
  final OnAudioQuery _onAudioQuery = Get.find();

  final List<int> _audioBuffer = [];

  final List<int> _imageBuffer = [];

  List<int> get imageBuffer => _imageBuffer;
  List<int> get audioBuffer => _audioBuffer;

  SongModel? currentSong;
  @override
  void onInit() {
    super.onInit();
    player.currentIndexStream.listen((int? index) async {
      if (index != null) {
        final songs = await provider.getAllMusic();
        final song = songs.elementAt(index);
        currentSong = song;
        update([
          'mini_track_image',
          'mini_track_info',
          'player_image',
          'player_info',
          'library_list_tile'
        ]);
        await updatePaletteGenerator();
      }
    });
  }

  Future<void> updatePaletteGenerator() async {
    final Uint8List? image =
        await _onAudioQuery.queryArtwork(currentSong!.id, ArtworkType.AUDIO);
    if (image != null) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        MemoryImage(image),
        maximumColorCount: 20,
      );
      update(['player_color', 'player_shadow_color']);
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(SongModel song) async {
    currentSong = song;
    final songs = await provider.getAllMusic();
    final currentIndex =
        songs.indexWhere((element) => element.id == currentSong!.id);
    final audioSource = await player.setAudioSource(
        ConcatenatingAudioSource(
            children: List.generate(
          songs.length,
          (index) => AudioSource.uri(
            Uri.file(songs[index].data),
          ),
        )),
        initialIndex: currentIndex);

    if (audioSource != null) {
      await player.play();
    }
  }

  void loadDiffusion() async {
    final source = await player
        .setAudioSource(AudioSource.uri(Uri.dataFromBytes(_audioBuffer)));

    if (source != null) {
      await player.load();
    }
  }

  void playDiffusion() {
    player.play();
  }

  void togglePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }
}
