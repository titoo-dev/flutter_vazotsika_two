import 'package:flutter/material.dart';
import 'package:flutter_vazotsika_two/app/service/socket_client.dart';
import '../../../routes/app_pages.dart';
import '../../../service/streaming_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../service/player_service.dart';
import 'package:get/get.dart';

import '../../../provider/audio_provider.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  RxBool isLoadingArtist = false.obs;
  RxBool isLoadingSong = false.obs;

  final OnAudioQuery audioQuery = Get.find();

  late final AnimationController playingStateAnimation;
  late final AnimationController bottomSheetAnimation;

  late AnimationController _nearbyAnimationController;
  AnimationController get nearbyAnimationController =>
      _nearbyAnimationController;

  final StreamingService _streamingService = Get.find();
  final AudioProvider _audioProvider = Get.find();
  final PlayerService _playerService = Get.find();
  final SocketClient _socketClient = Get.find();

  List<ArtistModel> artist = [];
  List<SongModel> songs = [];

  PlayerService get playerService => _playerService;

  Future<List<SongModel>> get getAllMusic => _audioProvider.getAllMusic();
  Future<List<ArtistModel>> get getAllArtist => _audioProvider.getAllArtist();

  final List<BottomNavigationBarItem> bottomNavBaritems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: "Library"),
    const BottomNavigationBarItem(icon: Icon(Icons.radio), label: "Streaming"),
  ];

  SongModel? get currentSong => _playerService.currentSong;

  late final TabController tabController;

  @override
  void onInit() async {
    super.onInit();
    playingStateAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    bottomSheetAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    tabController = TabController(
        length: bottomNavBaritems.length, vsync: this, initialIndex: 0)
      ..addListener(() {
        update(['bottom_navbar']);
      });

    _nearbyAnimationController = AnimationController(
      vsync: this,
    );
  }

  @override
  void onReady() async {
    super.onReady();
    loadArtistList();
    loadSongList();
    startAnimation();
  }

  void startAnimation() {
    print("Starting Nearby Animation");
    _nearbyAnimationController.stop();
    _nearbyAnimationController.reset();
    _nearbyAnimationController.repeat(period: const Duration(seconds: 1));
  }

  void loadArtistList() async {
    isLoadingArtist.value = true;
    artist = await getAllArtist;
    isLoadingArtist.value = false;
  }

  void loadSongList() async {
    isLoadingSong.value = true;
    songs = await getAllMusic;
    isLoadingSong.value = false;
  }

  // navigation
  void toPlayerPage() {
    Get.toNamed(Routes.player, arguments: currentSong);
  }

  void handleTapBottomNavabarItem(int index) {
    tabController.animateTo(index);
    // update(['bottom_navbar']);
  }

  // player
  void playAudio({required SongModel audio}) {
    _playerService.playAudio(audio);
    // update(['bottom_sheet', 'library_song_tile']);
  }

  void togglePlayPause() {
    if (playerService.player.playing) {
      playingStateAnimation.forward();
    } else {
      playingStateAnimation.reverse();
    }
    _playerService.togglePlayPause();
  }

  void playDiffusion() {
    _playerService.playDiffusion();
    playingStateAnimation.forward();
  }

  void connectToServer() {
    _streamingService.joinStream();
  }

  void requestCurrentStreaming() {
    showLoading();
    _socketClient.socket.emit('current_song_request');
  }

  void showLoading() {
    Get.dialog(AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 14),
          Text("Fetching Song...")
        ],
      ),
    ));
  }

  bool getClientStatus() {
    return _streamingService.getClientStatus();
  }
}
