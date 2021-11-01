import '../provider/audio_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerService extends GetxController {
  final player = AudioPlayer();
  final AudioProvider provider = Get.find();

  final List<int> _audioBuffer = [];

  final List<int> _imageBuffer = [];

  List<int> get imageBuffer => _imageBuffer;
  List<int> get audioBuffer => _audioBuffer;

  SongModel? currentSong;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playAudio(SongModel song) async {
    currentSong = song;
    final audioSource =
        await player.setAudioSource(AudioSource.uri(Uri.file(song.data)));

    if (audioSource != null) {
      await player.play();
    }
  }

  void loadDiffusion() {
    player.setAudioSource(AudioSource.uri(Uri.dataFromBytes(_audioBuffer)));
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
