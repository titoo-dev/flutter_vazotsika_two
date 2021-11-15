import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:flutter_vazotsika_two/app/service/socket_client.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:socket_io/socket_io.dart';
import 'package:get/get.dart';

class SocketServer extends GetxController {
  late final Server _io;
  late final dynamic _nsp;
  final OnAudioQuery _onAudioQuery = Get.find();
  final PlayerService _playerService = Get.find();
  final SocketClient _socketClient = Get.find();

  SongModel? get currentSong => _playerService.currentSong;

  Server get io => _io;
  dynamic get nsp => _nsp;

  // set currentSong(SongModel value) => _currentSong = value;

  @override
  void onInit() {
    super.onInit();
    _io = Server();
    _nsp = _io.of('/');
  }

  void init() {
    print("initialisation server");
    _nsp.on('connection', (client) {
      print("User connected");

      client.on('message', (data) {
        print("Data from /some => $data");
      });

      client.on('current_song_request', handleCurrentSongRequest);

      client.on('transfert_done', (data) {
        print("Transfert done");
        _io.emit('current_position', _playerService.player.position.inSeconds);
      });
    });
  }

  void listen() async {
    _socketClient.close();
    await _io.listen(8080);
  }

  void close() async {
    await _io.close();
  }

  Future<bool> get ready => _io.ready;

  void emitEvent(String event, [dynamic data]) {
    _io.emit(event, data);
  }

  void handleCurrentSongRequest(dynamic data) async {
    print("New Current Song Request");
    if (currentSong != null) {
      try {
        final File file = File(currentSong!.data);
        Uint8List bytes = await file.readAsBytes();
        final Uint8List? songImage = await _onAudioQuery.queryArtwork(
            currentSong!.id, ArtworkType.AUDIO);

        _io.emit('transfert_image', songImage);
        _io.emit('start_transfert', bytes);
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void startTransfert({required SongModel songModel}) async {
    try {
      final File file = File(songModel.data);

      Uint8List bytes = await file.readAsBytes();

      _io.emit('start_transfert', bytes);
    } catch (e) {
      print("Error: $e");
    }
  }
}
