import 'package:flutter_vazotsika_two/app/service/socket_client.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

// import 'socket_server.dart';

class PlayerService extends GetxController {
  // final SocketServer _socketServer = Get.find();
  final SocketClient _socketClient = Get.find();
  final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(String path) {
    player.setAudioSource(AudioSource.uri(Uri.file(path)));
    player.play();
  }

  void loadDiffusion() {
    player.setAudioSource(
        AudioSource.uri(Uri.dataFromBytes(_socketClient.buffer)));
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
