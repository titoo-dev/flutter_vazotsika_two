import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/network_service.dart';
import 'package:flutter_vazotsika_two/app/service/player_service.dart';
import 'package:get/get.dart';

import 'app/provider/audio_provider.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      onInit: () {
        Get.put(NetworkService());
        Get.put(AudioProvider());
        Get.put(PlayerService());
      },
    ),
  );
}
