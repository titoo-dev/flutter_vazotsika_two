import 'dart:typed_data';

import 'package:socket_io_client/socket_io_client.dart'
    show Socket, OptionBuilder, io;
// import 'package:get_server/get_server.dart';
import 'package:get/get.dart';

class SocketClient extends GetxController {
  List<int> buffer = [];
  List<Uint8List> playlist = [];

  void init() {
    print("initialisation client");
    Socket socket = io('http://localhost:8080',
        OptionBuilder().setTransports(['websocket']).build());
    socket.connect();

    socket.on('connect', (data) {
      print("Connected");
      socket.emit("message", "Hello Sever");
    });

    socket.on('from server', (data) {
      print("data => $data");
    });

    socket.on('start_transfert', handleStartTransfert);

    socket.on('transfert_done', handleTransfertDone);
  }

  void handleStartTransfert(data) {
    buffer.clear();
    final List<int> payload = data.cast<int>();
    for (var i = 0; i < payload.length; i++) {
      buffer.add(payload[i]);
    }
    print("transfert ==> $payload");
  }

  void handleTransfertDone(data) async {
    print("transfert done ! ==> $buffer");
  }
}
