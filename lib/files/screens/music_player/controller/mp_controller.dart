import 'dart:async';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/controller/mp_audio_player.dart';

class MpController extends GetxController {
  RxList<TuneInfo> tuneList = <TuneInfo>[].obs;
  Rx<TuneInfo> toneinfo = TuneInfo().obs;
  RxInt currentIndex = 0.obs;
  RxBool isPlaying = false.obs;
  RxBool isPaused = false.obs;
  RxBool isLoading = false.obs;
  RxString playingUrl = ''.obs;

  RxBool isMusicPlayerOpen = false.obs;
  RxBool isMusicPlayerFullScreen = false.obs;
  RxDouble sliderValue = 0.0.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  RxBool isSeeking = false.obs; // prevents slider jump while dragging

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;

  StreamSubscription<PlayerState>? _playerStateSub;

  @override
  void onInit() {
    super.onInit();
    _listenToPlayerState();
    _listenToPosition();
    _listenToDuration();
  }

  void _listenToPosition() {
    _positionSub = MpAudioPlayer.instance.positionStream.listen((pos) {
      if (!isSeeking.value) {
        position.value = pos;
        final dur = duration.value.inMilliseconds;
        if (dur > 0) {
          sliderValue.value = pos.inMilliseconds / dur;
        }
      }
    });
  }

  void _listenToDuration() {
    _durationSub = MpAudioPlayer.instance.durationStream.listen((dur) {
      if (dur != null) {
        duration.value = dur;
      }
    });
  }

  void seekTo(double value) {
    final newPosition = Duration(
      milliseconds: (value * duration.value.inMilliseconds).toInt(),
    );
    isSeeking.value = false;
    MpAudioPlayer.instance.playerSeek(newPosition);
    MpAudioPlayer.instance.play();
    sliderValue.value = value;
  }

  void _listenToPlayerState() {
    _playerStateSub = MpAudioPlayer.instance.playerStateStream.listen((state) {
      final processing = state.processingState;

      isLoading.value = processing == ProcessingState.loading ||
          processing == ProcessingState.buffering;

      isPlaying.value = state.playing &&
          processing != ProcessingState.loading &&
          processing != ProcessingState.buffering;

      isPaused.value = !state.playing && processing == ProcessingState.ready;

      // ── Reset on completion ──
      if (processing == ProcessingState.completed) {
        isPlaying.value = false;
        isPaused.value = false;
        isLoading.value = false;
        playingUrl.value = ''; // clears the active song → icon resets to play
      }

      print(
          'SKY >> isLoading: ${isLoading.value} | isPlaying: ${isPlaying.value} | isPaused: ${isPaused.value} | processing: $processing');
    });
  }

  playUrl(TuneInfo tuneInfo) {
    toneinfo.value = tuneInfo;
    playingUrl.value = tuneInfo.toneIdStreamingUrl ?? '';
    MpAudioPlayer.instance.playUrl(tuneInfo.toneIdStreamingUrl ?? '', null);
    isMusicPlayerOpen.value = true;
    currentIndex.value = tuneList.indexWhere(
        (tune) => tune.toneIdStreamingUrl == tuneInfo.toneIdStreamingUrl);
  }

  pauseAudio() => MpAudioPlayer.instance.pause();
  resumeAudio() => MpAudioPlayer.instance.resume();
  playAudio() => MpAudioPlayer.instance.play();
  stopAudio() => MpAudioPlayer.instance.stop();

  playNext() {
    final currentIndex1 = currentIndex.value;
    final nextIndex = (currentIndex1 + 1) % tuneList.length;
    final nextTune = tuneList[nextIndex];
    playUrl(nextTune);
  }

  playPrevious() {
    final currentIndex1 = currentIndex.value;
    final nextIndex = (currentIndex1 - 1) % tuneList.length;
    final nextTune = tuneList[nextIndex];
    playUrl(nextTune);
  }

  // @override
  // void onClose() {
  //   _playerStateSub?.cancel();
  //   super.onClose();
  // }
  @override
  void onClose() {
    _playerStateSub?.cancel();
    _positionSub?.cancel();
    _durationSub?.cancel();
    super.onClose();
  }
}
