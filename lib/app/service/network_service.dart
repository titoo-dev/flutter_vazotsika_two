import 'socket_client.dart';

import 'socket_server.dart';
import 'package:get/get.dart';

class NetworkService extends GetxController {
  final SocketClient socketclient = Get.put(SocketClient());
  final SocketServer socketServer = Get.put(SocketServer());
  @override
  void onInit() async {
    super.onInit();
    socketServer.init();
    socketclient.init();
  }
}
