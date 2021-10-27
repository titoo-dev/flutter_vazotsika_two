// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/animation.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:flutter_vazotsika_two/app/service/socket_server.dart';
import 'package:get/get.dart';

import '../../../provider/audio_provider.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  late final AnimationController playingStateAnimation;

  final SocketServer _socketServer = Get.find();
  final AudioProvider _audioProvider = Get.find();
  final PlayerService _playerService = Get.find();

  PlayerService get playerService => _playerService;

  Future<List<SongInfo>> get getAllMusic => _audioProvider.getAllMusic();
  Future<List<ArtistInfo>> get getAllArtist => _audioProvider.getAllArtist();

  @override
  void onInit() {
    super.onInit();
    playingStateAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
  }

  void playAudio(String path) {
    _playerService.playAudio(path);
  }

  void togglePlayPause() {
    if (playerService.player.playing) {
      playingStateAnimation.forward();
    } else {
      playingStateAnimation.reverse();
    }
    _playerService.togglePlayPause();
  }

  void diffuseSong({required SongInfo songInfo}) {
    _socketServer.startTransfert(songInfo: songInfo);
  }

  void playDiffusion() {
    _playerService.loadDiffusion();
  }
}
