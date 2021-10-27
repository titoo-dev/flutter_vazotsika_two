import 'dart:io';
import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:socket_io/socket_io.dart';
import 'package:get/get.dart';

class SocketServer extends GetxController {
  late final Server _io;
  late final dynamic _nsp;

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
    });

    _io.listen(8080);
  }

  void startStream({required dynamic data}) {
    _io.emit('from server', data);
  }

  void startTransfert({required SongInfo songInfo}) async {
    try {
      final File file = File(songInfo.filePath);

      Uint8List bytes = await file.readAsBytes();

      _io.emit('start_transfert', bytes);
    } catch (e) {
      print("Error: $e");
    }
  }
}
