import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

// import 'socket_server.dart';

class PlayerService extends GetxController {
  // final SocketServer _socketServer = Get.find();
  final player = AudioPlayer();

  final List<int> _buffer = [];

  List<int> get buffer => _buffer;

  SongModel? currentSong;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(SongModel song) {
    currentSong = song;
    player.setAudioSource(AudioSource.uri(Uri.file(song.data)));
    player.play();
  }

  void loadDiffusion() {
    player.setAudioSource(AudioSource.uri(Uri.dataFromBytes(_buffer)));
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
