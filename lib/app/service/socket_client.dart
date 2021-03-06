import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:socket_io_client/socket_io_client.dart'
    show Socket, OptionBuilder, io;
// import 'package:get_server/get_server.dart';
import 'package:get/get.dart';

class SocketClient extends GetxController {
  final PlayerService _playerService = Get.find();
  late final Socket socket;
  List<Uint8List> playlist = [];

  RxBool isJoined = false.obs;

  void init() {
    print("initialisation client");
    socket = io(
        'http://192.168.43.1:8080',
        OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableReconnection()
            .build());

    socket.on('connect', (data) {
      print("Connected");
      isJoined.value = true;
    });

    socket.on('disconnect', (data) {
      print("disconnected");
      isJoined.value = false;
      _playerService.player.stop();
    });

    socket.on('from server', (data) {
      print("data => $data");
    });

    socket.on('transfert_image', handleStartTransfertImage);
    socket.on('start_transfert', handleStartTransfert);

    socket.on('current_position', handlecurrentPosition);
  }

  bool get isConnected => socket.connected;

  void handlecurrentPosition(dynamic data) {
    print(data);
    if (_playerService.player.position.inMilliseconds != data) {
      _playerService.player.seek(Duration(milliseconds: data));
    }
  }

  void listen() {
    socket.connect();
  }

  void close() {
    socket.close();
  }

  void request(String event, [dynamic data]) {
    socket.emit(event, data);
  }

  void handleStartTransfertImage(data) {
    print("Getting Image");
    final List<int> payload = data.cast<int>();
    for (var i = 0; i < payload.length; i++) {
      _playerService.imageBuffer.add(payload[i]);
    }
    print(data);
  }

  void handleStartTransfert(data) {
    print("Getting Audio");
    _playerService.audioBuffer.clear();
    final List<int> payload = data.cast<int>();
    for (var i = 0; i < payload.length; i++) {
      _playerService.audioBuffer.add(payload[i]);
    }
    print(data);
    _playerService.loadDiffusion();
    update(['streaming_image']);
    Get.back();
    Get.rawSnackbar(
        messageText: const Text(
      "Ready for streaming",
      style: TextStyle(color: Colors.white),
    ));
    socket.emit('transfert_done');
  }

  void handleTransfertDone(data) async {
    print("transfert done ! ==> ${_playerService.audioBuffer}");
  }
}
