import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/provider/audio_provider.dart';
import 'app/routes/app_pages.dart';
import 'app/service/network_service.dart';
import 'app/service/player_service.dart';
import 'app/service/streaming_service.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(primarySwatch: Colors.orange),
      themeMode: ThemeMode.light,
      onInit: () {
        Get.put(AudioProvider());
        Get.put(PlayerService());
        Get.put(NetworkService());
        Get.put(StreamingService());
      },
    ),
  );
}
