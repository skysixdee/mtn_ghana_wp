import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/player_view/custom_audio_player.dart';
import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';

class PlayerController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isRepeat = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isShuffle = false.obs;
  RxBool isHideBuyButton = false.obs;
  RxBool isPlayerVisible = false.obs;
  RxBool isPlayerMaxSize = false.obs;
  RxInt playingIndex = 0.obs;
  RxString playingUrl = ''.obs;
  Rx<TuneInfo> info = TuneInfo().obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;

  RxList<String> artistList = <String>[].obs;
  RxDouble totalDuration = 0.0.obs;
  RxDouble currentPosition = 0.0.obs;
  Rx<MyPlayerState> myPlayerState = MyPlayerState.completed.obs;

  Function()? onMaxSize;

  @override
  void onInit() {
    super.onInit();

    CustomAudioPlayer.instance.barPosition = (v) {
      //print("Sky = bar $v");
      currentPosition.value = v.toDouble();
    };
    CustomAudioPlayer.instance.maxDuration = (v) {
      //print("Sky = max $v");
      totalDuration.value = v.toDouble();
    };
    CustomAudioPlayer.instance.onComplete = () {
      nextButton();
    };
    CustomAudioPlayer.instance.buffering = () {};
    CustomAudioPlayer.instance.idle = () {
      //isPlaying.value = false;
      isLoading.value = false;
    };
    CustomAudioPlayer.instance.ready = () {
      //isPlaying.value = true;
      isLoading.value = false;
    };
    CustomAudioPlayer.instance.loading = () {
      //isLoading.value = true;
    };
    CustomAudioPlayer.instance.myPlayerState = (v) {
      myPlayerState.value = v;
    };
  }

  maximizePlayer(bool value) {
    isPlayerMaxSize.value = value;
    if (onMaxSize != null) {
      onMaxSize!();
    }
  }

  playPause() {
    //CustomAudioPlayer.instance.pause();

    if (myPlayerState.value == MyPlayerState.playing) {
      CustomAudioPlayer.instance.pause();
    } else {
      CustomAudioPlayer.instance.resume();
    }
    //isPlaying.value = !isPlaying.value;
  }

  playList(List<TuneInfo> list, int index) async {
    String streamingUrl = list[index].toneIdStreamingUrl ?? '';
    if (streamingUrl == info.value.toneIdStreamingUrl) {
      CustomAudioPlayer.instance.pause();
      //isPlaying.value = !isPlaying.value;
    } else {
      playingIndex.value = index;
      info.value = list[index];
      if (listEquals(this.list, list)) {
        print("same categry try to add ");
      } else {
        print("new  categry try to add ");
      }
      this.list.value = list;

      print("list of artist is ${artistList.length}");
      print("list of artist is1 ${artistList.toSet().toList().length}");
      artistList.clear();
      artistList.value = list
          .map((v) {
            if (v.artistName?.isEmpty ?? true) {
              return '';
            } else {
              return v.artistName ?? '';
            }
          })
          .toSet()
          .toList();

      print("length of artistList ${artistList.length}");
      playingUrl.value = info.value.toneIdStreamingUrl ?? '';
      CustomAudioPlayer.instance.playUrl(playingUrl.value);
      //isPlaying.value = true;
    }

    print('Items are ${list.length}');
  }

  play(TuneInfo info, int index) {
    playingIndex.value = index;
    this.info.value = info;
    playingUrl.value = info.toneIdStreamingUrl ?? '';
    CustomAudioPlayer.instance.playUrl(playingUrl.value);
    //isPlaying.value = true;
  }

  stop() {
    playingUrl.value = '';
    // isPlaying.value = false;
    CustomAudioPlayer.instance.stop();
  }

  nextButton() async {
    isRepeat.value = false;

    if (isShuffle.value) {
      randomPlayingIndex();
    } else {
      if (playingIndex.value >= (list.length - 1)) {
        CustomAudioPlayer.instance.stop();
        return;
      }

      playingIndex.value += 1;
    }

    info.value = list[playingIndex.value];
    playingUrl.value = list[playingIndex.value].toneIdStreamingUrl ?? '';
    CustomAudioPlayer.instance.playUrl(info.value.toneIdStreamingUrl ?? '');
  }

  playAtIndex(int index) {
    playingIndex.value = index;

    info.value = list[playingIndex.value];
    playingUrl.value = list[playingIndex.value].toneIdStreamingUrl ?? '';
    CustomAudioPlayer.instance.playUrl(info.value.toneIdStreamingUrl ?? '');
  }

  previousButton() async {
    isRepeat.value = false;

    if (isShuffle.value) {
      randomPlayingIndex();
    } else {
      if (playingIndex.value <= 0) {
        CustomAudioPlayer.instance.stop();
        return;
      }

      playingIndex.value -= 1;
    }

    info.value = list[playingIndex.value];
    playingUrl.value = list[playingIndex.value].toneIdStreamingUrl ?? '';
    CustomAudioPlayer.instance.playUrl(info.value.toneIdStreamingUrl ?? '');
  }

  repeatAction() {
    isRepeat.value = !isRepeat.value;
    isShuffle.value = false;
  }

  shuffleAction() {
    isRepeat.value = false;
    isShuffle.value = !isShuffle.value;
  }

  void seekAudio(double value) {
    CustomAudioPlayer.instance
        .playerSeek(Duration(milliseconds: value.toInt()));
    currentPosition.value = value.toDouble();
  }

  randomPlayingIndex() {
    int min = 0; // Your minimum value
    int max = list.length; // Your maximum value

    Random random = Random();
    playingIndex.value = min + random.nextInt(max - min + 1);
  }
}
