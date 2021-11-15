import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/player/bindings/player_binding.dart';
import '../modules/player/views/player_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.onBoarding;

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
    GetPage(
        name: _Paths.onBoarding,
        page: () => OnBoardingView(),
        binding: OnBoardingBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.AUTHENTICATION,
        page: () => const AuthenticationView(),
        binding: AuthenticationBinding(),
        transition: Transition.cupertino),
  ];
}
