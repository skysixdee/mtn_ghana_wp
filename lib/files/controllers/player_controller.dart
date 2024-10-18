import 'package:mtn_ghana_wp/files/common/custom_audio_player.dart';
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  RxString playingToneId = '-1'.obs;
  RxBool _isPlaying = false.obs;
  late TuneInfo info;
  playUrl(TuneInfo info) async {
    this.info = info;
    print("playing tone name = ${info.toneName}");
    if (playingToneId.value == (info.toneId ?? '')) {
      if (_isPlaying.value) {
        await pause();
      } else {
        await resume();
      }
    } else {
      await CustomAudioPlayer.instance.playUrl(info.toneIdStreamingUrl ?? '',
          (player) {
        _playerState(player);
      }, () async {
        await stop();
        return;
      });

      await play();
      tunePlayClickEvent(info);
    }
  }

  Future<void> pause() async {
    print("paused tapped");

    await CustomAudioPlayer.instance.pause();
  }

  Future<void> playPause() async {
    if (_isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  Future<void> play() async {
    print(" play called");
    await CustomAudioPlayer.instance.play();
  }

  Future<void> resume() async {
    print("Resume called");
    await CustomAudioPlayer.instance.resume();
  }

  Future<void> stop() async {
    print("Stop called");
    await CustomAudioPlayer.instance.stop();
    playingToneId.value = '';
  }

  _playerState(AudioPlayer player) async {
    player.playerStateStream.listen((state) {
      if (state.playing) {
        switch (state.processingState) {
          case ProcessingState.idle:
            print("idle  =SKY==  ProcessingState.idle   ");

            break;
          case ProcessingState.loading:
            print("loading  =SKY==  ProcessingState.loading   ");

            break;
          case ProcessingState.buffering:
            print("buffering  =SKY==  ProcessingState.buffering   ");

            break;
          case ProcessingState.ready:
            print("ready  =SKY==  ProcessingState.ready   ");
            _isPlaying.value = true;
            playingToneId.value = info.toneId ?? '';
            break;
          case ProcessingState.completed:
            print("completed  =SKY==  ProcessingState.completed   ");
            playingToneId.value = '';
            break;
        }
      } else {
        print("Player is not playing");
        _isPlaying.value = false;
        playingToneId.value = '';
      }
    });
    /*
    player.positionStream.listen((position) {
      currentSeekingStr.value = position.inSeconds > 9
          ? "00:${position.inSeconds}"
          : "00:0${position.inSeconds}";
      ;
      current.value = position.inSeconds;
      maxDuration.value = player.duration?.inSeconds ?? 0;

      maxDurationStr.value = (player.duration?.inSeconds ?? 0) > 9
          ? "00:${player.duration?.inSeconds}"
          : "00:0${player.duration?.inSeconds}";
    });
    */
  }
}
  /*
  RxBool isPlaying = false.obs;
  bool stopStatePring = true;
  RxInt playingIndex = 9999999.obs;
  RxBool isBuffering = false.obs;
  bool _isPaused = false;
  bool _isCompleted = false;
  RxString tuneName = ''.obs;
  RxString artistName = ''.obs;
  RxString tuneImage = ''.obs;
  RxInt current = 0.obs;
  RxInt maxDuration = 0.obs;
  RxString maxDurationStr = '00:00'.obs;
  RxString currentSeekingStr = '00:00'.obs;
  late TuneInfo? info;
  String playingUrl = '';
  playUrl(TuneInfo? info, int index) async {
    this.info = info;
    tuneName.value = info?.toneName ?? '';
    artistName.value = info?.artistName ?? '';
    tuneImage.value =
        info?.toneIdpreviewImageUrl ?? info?.previewImageUrl ?? '';
    print(
        "1 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");

    if (playingUrl == (playingUrl = info?.toneIdStreamingUrl ?? '')) {
      playingIndex.value = index;
      playingUrl = info?.toneIdStreamingUrl ?? '';
      print(
          "2 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying$isPlaying");
      if (_isPaused) {
        await resume();
      } else {
        await pause();
      }
      print("Is playing status $isPlaying");
      return;
    } else {
      playingIndex.value = index;
      playingUrl = info?.toneIdStreamingUrl ?? '';
      print(
          "3 was $playingIndex and is $index  _isPaused $_isPaused  isPlaying $isPlaying");
      isBuffering.value = true;
      await OmlAudioPlayer.instance.playUrl(info?.toneIdStreamingUrl ?? '',
          (player) {
        _playerState(player);
      }, () async {
        await stop();
        return;
      });

      await play();
    }
  }

  Future<void> play() async {
    isPlaying.value = true;
    _isPaused = false;
    await OmlAudioPlayer.instance.play();
  }

  Future<void> seekTo(Duration position) async {
    await OmlAudioPlayer.instance.playerSeek(position);
  }

  Future<void> pause() async {
    _isPaused = true;
    print("paused tapped");
    isPlaying.value = false;
    await OmlAudioPlayer.instance.pause();
  }

  Future<void> playPause() async {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  Future<void> resume() async {
    _isPaused = false;
    isPlaying.value = true;
    await OmlAudioPlayer.instance.resume();
  }

  Future<void> stop() async {
    await OmlAudioPlayer.instance.stop();
    current.value = 0;
    playingUrl = '';
    playingIndex.value = -1;
    playingUrl = '';
    isPlaying.value = false;
    _isCompleted = true;
    _isPaused = false;
  }

  _playerState(AudioPlayer player) async {
    error(player);
    player.playerStateStream.listen((state) {
      isBuffering.value = false;
      if (state.playing) {
        switch (state.processingState) {
          case ProcessingState.idle:
            if (stopStatePring) {
              print("idle  =SKY==  ProcessingState.idle   ");
            }

            break;
          case ProcessingState.loading:
            if (stopStatePring) {
              print("loading  =SKY==  ProcessingState.loading   ");
              isBuffering.value = true;
            }
            break;
          case ProcessingState.buffering:
            if (stopStatePring) {
              print("buffering  =SKY==  ProcessingState.buffering   ");
            }
            isBuffering.value = true;
            break;
          case ProcessingState.ready:
            if (stopStatePring) {
              print("ready  =SKY==  ProcessingState.ready   ");
            }

            break;
          case ProcessingState.completed:
            if (stopStatePring) {
              print("completed  =SKY==  ProcessingState.completed   ");
            }
            playingIndex.value = -1;
            playingUrl = '';
            isPlaying.value = false;
            _isCompleted = true;
            _isPaused = false;
            break;
        }
      } else {
        isPlaying.value = false;
        _isPaused = true;
        print("Player is not playing");
      }
    });
    player.positionStream.listen((position) {
      currentSeekingStr.value = position.inSeconds > 9
          ? "00:${position.inSeconds}"
          : "00:0${position.inSeconds}";
      ;
      current.value = position.inSeconds;
      maxDuration.value = player.duration?.inSeconds ?? 0;

      maxDurationStr.value = (player.duration?.inSeconds ?? 0) > 9
          ? "00:${player.duration?.inSeconds}"
          : "00:0${player.duration?.inSeconds}";
    });
  }

  error(AudioPlayer player) {
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('SKY Error code: ${e.code}');
        print('SKY Error message: ${e.message}');
      } else {
        print('SKY An error occurred: $e');
      }
    });
  }
}
*/