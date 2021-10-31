import 'dart:io';
import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:socket_io/socket_io.dart';
import 'package:get/get.dart';

class SocketServer extends GetxController {
  late final Server _io;
  late final dynamic _nsp;

  SongModel? _currentSong;

  Server get io => _io;
  dynamic get nsp => _nsp;

  set currentSong(SongModel value) => _currentSong = value;

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
      });
    });
  }

  void listen() async {
    await _io.listen(8080);
  }

  void close() async {
    await _io.close();
  }

  Future<bool> get ready => _io.ready;

  void emitEvent(String event, [dynamic data]) {
    _io.emit(event, data);
  }

  void startStream({required dynamic data}) {
    _io.emit('from server', data);
  }

  void handleCurrentSongRequest(dynamic data) async {
    print("New Current Song Request");
    try {
      final File file = File(_currentSong!.data);

      Uint8List bytes = await file.readAsBytes();

      _io.emit('start_transfert', bytes);
    } catch (e) {
      print("Error: $e");
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
