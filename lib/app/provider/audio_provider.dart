import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';

class AudioProvider extends GetxController {
  final OnAudioQuery _onAudioQuery = Get.put(OnAudioQuery());

  late List<SongModel> _songs;
  late List<ArtistModel> _artists;

  Future<List<SongModel>> getAllMusic() async {
    _songs = await _onAudioQuery.querySongs(
        uriType: UriType.EXTERNAL, ignoreCase: true);
    return _songs;
  }

  Future<List<ArtistModel>> getAllArtist() async {
    _artists = await _onAudioQuery.queryArtists(
        uriType: UriType.EXTERNAL, ignoreCase: true);
    return _artists;
  }

  @override
  void onInit() {
    super.onInit();
    _onAudioQuery.permissionsRequest();
  }
}
