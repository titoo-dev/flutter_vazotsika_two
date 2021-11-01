import 'package:get/get.dart';

import 'package:flutter_vazotsika_two/app/modules/player/bindings/player_binding.dart';
import 'package:flutter_vazotsika_two/app/modules/player/views/player_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.player,
      page: () => const PlayerView(),
      binding: PlayerBinding(),
    ),
  ];
}
