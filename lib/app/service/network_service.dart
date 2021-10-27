import 'socket_client.dart';

import 'socket_server.dart';
import 'package:get/get.dart';

class NetworkService extends GetxController {
  final SocketServer socketServer = Get.put(SocketServer());
  final SocketClient socketclient = Get.put(SocketClient());
  @override
  void onInit() async {
    super.onInit();
    socketServer.init();
    socketclient.init();
  }
}
