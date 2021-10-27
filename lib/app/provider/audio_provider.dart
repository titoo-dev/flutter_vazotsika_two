import 'dart:typed_data';

import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioProvider extends GetxController {
  final FlutterAudioQuery _flutterAudioQuery = FlutterAudioQuery();

  late List<SongInfo> _songs;
  late List<ArtistInfo> _artists;

  Future<List<SongInfo>> getAllMusic() async {
    _songs = await _flutterAudioQuery.getSongs();
    return _songs;
  }

  Future<List<ArtistInfo>> getAllArtist() async {
    _artists = await _flutterAudioQuery.getArtists();
    return _artists;
  }
}
