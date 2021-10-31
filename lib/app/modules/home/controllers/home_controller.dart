import 'package:flutter/material.dart';
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

  final StreamingService _streamingService = Get.find();
  final AudioProvider _audioProvider = Get.find();
  final PlayerService _playerService = Get.find();

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

  SongModel? currentSong;

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
  }

  @override
  void onReady() {
    super.onReady();
    loadArtistList();
    loadSongList();
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
    Get.toNamed(Routes.PLAYER, arguments: currentSong);
  }

  void handleTapBottomNavabarItem(int index) {
    tabController.animateTo(index);
    // update(['bottom_navbar']);
  }

  // player
  void playAudio({required SongModel audio}) {
    _playerService.playAudio(audio);
    currentSong = audio;
    _streamingService.setupServerCurrentStreaming(audio);
    update(['bottom_sheet', 'mini_track', 'library_song_tile']);
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
    _playerService.loadDiffusion();
  }

  void connectToServer() {
    _streamingService.joinStream();
  }

  void requestCurrentStreaming() {
    _streamingService.requestCurrentStreamig();
  }

  bool getClientStatus() {
    return _streamingService.getClientStatus();
  }
}
