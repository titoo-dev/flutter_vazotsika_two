import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  RxInt currentPageValue = 0.obs;

  void getChangedPageAndMoveBar(int value) {
    currentPageValue.value = value;
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }

  void toLogin() {
    Get.offAndToNamed(Routes.AUTHENTICATION);
  }
}
