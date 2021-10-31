import 'package:flutter/material.dart';
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

  SongModel? currentSong;

  @override
  void onInit() {
    super.onInit();
    currentSong = Get.arguments;
    print(currentSong);
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

    // Start Streaming event
    // playerService.player.positionStream.listen((position) {
    //   if (position.inSeconds % 10 == 0) {
    //     _streamingService.emitEvent('current_position', position.inSeconds);
    //   }
    // });
  }

  void sharePosition() {
    _streamingService.emitEvent(
        'current_position', playerService.player.position.inMilliseconds);
  }

  void closeStreaming() {
    _streamingService.closeStream();
    update(['radio_icon']);
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
