import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/artist_list.dart';
import '../widgets/heading_text.dart';
import '../widgets/music_bottom_sheet.dart';
import '../widgets/recent_song_grid.dart';
import 'library_view.dart';
import 'streaming_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const MusicBottomSheet(),
      bottomNavigationBar: GetBuilder<HomeController>(
          id: 'bottom_navbar',
          builder: (_) {
            return BottomNavigationBar(
                items: _.bottomNavBaritems,
                currentIndex: _.tabController.index,
                onTap: _.handleTapBottomNavabarItem);
          }),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                HeadingText(),
                ArtistList(),
                Divider(
                  thickness: 1,
                ),
                RecentSongGrid()
              ],
            ),
          ),
          const LibraryView(),
          const StreamingView()
        ],
      ),
    );
  }
}
