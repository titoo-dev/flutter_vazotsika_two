import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/socket_server.dart';
import '../../../service/player_service.dart';
import '../../../service/streaming_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController
    with SingleGetTickerProviderMixin {
  final PlayerService _playerService = Get.find();
  final StreamingService _streamingService = Get.find();

  late final AnimationController playingStateAnimation;

  PlayerService get playerService => _playerService;

  SongModel? get currentSong => _playerService.currentSong;

  final SocketServer socketServer = Get.find();

  @override
  void onInit() {
    super.onInit();
    playingStateAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  void togglePlayPause() {
    if (playerService.player.playing) {
      playingStateAnimation.forward();
    } else {
      playingStateAnimation.reverse();
    }
    _playerService.togglePlayPause();
  }

  void handleSeek(double value) {
    playerService.player.seek(Duration(seconds: value.toInt()));
  }

  void back() {
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
    playerService.player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        playerService.player.seek(Duration.zero);
        playerService.player.stop();
        playingStateAnimation.forward();
      }
    });
  }

  void startStreaming() {
    _streamingService.startStream();
    update(['radio_icon']);
    Get.rawSnackbar(
        animationDuration: const Duration(milliseconds: 600),
        messageText: const Text("Server Started",
            style: TextStyle(color: Colors.white)));

    // Start Streaming event
    playerService.player.positionStream.listen((position) {
      if (position.inSeconds % 10 == 0) {
        _streamingService.emitEvent('current_position', position.inSeconds);
      }
    });
  }

  void sharePosition() {
    _streamingService.emitEvent(
        'current_position', playerService.player.position.inMilliseconds + 90);
  }

  void closeStreaming() {
    _streamingService.closeStream();
    update(['radio_icon']);
    Get.rawSnackbar(
        animationDuration: const Duration(milliseconds: 600),
        messageText: const Text("Server Stopped",
            style: TextStyle(color: Colors.white)));
  }

  bool get isStreaming => _streamingService.isStreaming;

  void toggleStreaming() {
    if (isStreaming) {
      closeStreaming();
    } else {
      startStreaming();
    }
  }

  @override
  void dispose() {
    playingStateAnimation.dispose();
    super.dispose();
  }
}
