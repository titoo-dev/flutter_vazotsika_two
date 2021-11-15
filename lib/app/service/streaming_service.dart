import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'socket_client.dart';
import 'socket_server.dart';

class StreamingService extends GetxController {
  final SocketServer socketServer = Get.find();
  final SocketClient socketclient = Get.find();

  bool isStreaming = false;

  // void setupServerCurrentStreaming(SongModel songInfo) {
  //   socketServer.currentSong = songInfo;
  // }

  bool getClientStatus() {
    return socketclient.isConnected;
  }

  void startStream() {
    socketServer.listen();
    isStreaming = true;
  }

  void closeStream() {
    socketServer.close();
    isStreaming = false;
  }

  void joinStream() {
    socketclient.listen();
  }

  void emitEvent(String event, dynamic data) {
    socketServer.emitEvent(event, data);
  }

  void streamCurrentPosition(int position) {
    socketServer.emitEvent('current_position', position);
  }

  void requestCurrentStreamig() {
    socketclient.request('current_song_request');
  }
}
