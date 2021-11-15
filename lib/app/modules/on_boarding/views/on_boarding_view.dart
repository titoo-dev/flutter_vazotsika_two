import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/on_boarding_controller.dart';
import '../widget/dots.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  OnBoardingView({Key? key}) : super(key: key);
  final List<Widget> pages = [
    const OnBoardingContent(
      image: 'assets/lottie/11123-music.json',
      color: Colors.blue,
      title: "Diffusez votre music autour de vous",
      description:
          "Vazotsika vous permet de diffuser votre musique avec vos amis en temps reel",
    ),
    const OnBoardingContent(
      image: 'assets/lottie/lf30_editor_h0o5ula8.json',
      color: Colors.amber,
      title: "Accessible, Legere et rapide",
      description: "Vous pouvez jouer vorte musique en un rien de temps",
    ),
    const OnBoardingContent(
      image: 'assets/lottie/71611-singing-and-playing-music-with-guitar.json',
      color: Colors.green,
      title: "Accès multiples",
      description:
          "Acceder à vos musiques préferé  en ligne ou sur votre appareil",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: controller.pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: controller.getChangedPageAndMoveBar,
            children: pages,
          ),
          GetX<OnBoardingController>(
            builder: (state) => Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 34.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      if (i == controller.currentPageValue.value) ...[
                        const Dots(
                          isActive: true,
                        )
                      ] else
                        const Dots(
                          isActive: false,
                        )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: GetX<OnBoardingController>(
              builder: (state) => state.currentPageValue.value != 0
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: controller.previousPage,
                          child: const Text("back")),
                    )
                  : const SizedBox(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: GetX<OnBoardingController>(
              builder: (state) =>
                  state.currentPageValue.value != pages.length - 1
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: controller.nextPage,
                              child: const Text("Next")),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: controller.toLogin,
                              child: const Text("Commencer")),
                        ),
            ),
          )
        ],
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  final Color color;
  final String title;
  final String image;
  final String description;

  const OnBoardingContent(
      {Key? key,
      required this.color,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   width: 200,
        //   height: 200,
        //   decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        // ),
        Lottie.asset(image, width: 200, height: 200),
        const SizedBox(height: 30),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(description,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.black54))),
      ],
    );
  }
}
