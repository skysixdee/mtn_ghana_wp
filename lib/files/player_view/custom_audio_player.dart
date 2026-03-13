import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';

class CustomAudioPlayer {
  static final CustomAudioPlayer instance = CustomAudioPlayer._internal();
  late AudioPlayer _player;
  bool _listenersAttached = false;

  CustomAudioPlayer._internal() {
    print("initialize MtnAudioPlayer");
    _player = AudioPlayer();
    _attachListeners();
  }

  factory CustomAudioPlayer() => instance;

  Function(int)? maxDuration;
  Function(int)? barPosition;
  Function()? onComplete;
  Function()? idle;
  Function()? loading;
  Function()? buffering;
  Function()? ready;
  Function(MyPlayerState)? myPlayerState;

  // ─── KEY FIX: dispose old player and create a fresh one ───────────────────
  Future<void> _reinitPlayer() async {
    try {
      await _player.stop();
      await _player.dispose();
    } catch (_) {}
    _listenersAttached = false;
    _player = AudioPlayer();
    _attachListeners();
  }

  Future<void> playUrl(String url) async {
    print("playing url is1 $url");
    try {
      await _player.stop();
      await _player.setUrl(url);
      await _player.play();
      print("playing url is3 $url");
    } on PlatformException catch (e) {
      // ── Web: platform player already exists → reinit and retry once ────────
      print("SKY PlatformException: ${e.message} — reinitialising player");
      await _reinitPlayer();
      try {
        await _player.setUrl(url);
        await _player.play();
      } catch (e2) {
        print('SKY Retry failed: $e2');
      }
    } on PlayerException catch (e) {
      print("SKY Error code: ${e.code}");
      print("SKY Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("SKY Connection aborted: ${e.message}");
    } catch (e) {
      print('SKY An error occured: $e');
    }
  }

  void _attachListeners() {
    if (_listenersAttached) return;
    _listenersAttached = true;
    audioPosition();
    playerState();
  }

  audioPosition() {
    _player.durationStream.listen((duration) {
      if (maxDuration != null) maxDuration!(duration?.inMilliseconds ?? 0);
    });
    _player.positionStream.listen((position) {
      if (barPosition != null) barPosition!(position.inMilliseconds);
    });
  }

  playerState() {
    try {
      _player.playerStateStream.listen((state) async {
        print("SKY State is $state");
        switch (state.processingState) {
          case ProcessingState.idle:
            if (idle != null) idle!();
            if (myPlayerState != null) myPlayerState!(MyPlayerState.pause);
          case ProcessingState.loading:
            if (loading != null) loading!();
          case ProcessingState.buffering:
            if (buffering != null) buffering!();
            if (myPlayerState != null) myPlayerState!(MyPlayerState.loading);
          case ProcessingState.ready:
            if (state.playing) {
              if (myPlayerState != null) myPlayerState!(MyPlayerState.playing);
            } else {
              if (myPlayerState != null) myPlayerState!(MyPlayerState.pause);
            }
          case ProcessingState.completed:
            if (onComplete != null) onComplete!();
            await Future.delayed(const Duration(milliseconds: 200));
            if (barPosition != null) barPosition!(0);
        }
      });
    } catch (e) {
      print("error si == $e");
    }
  }

  playerSeek(Duration position) async => _player.seek(position);
  Future<void> play() async => _player.play();
  Future<void> pause() async => _player.pause();
  Future<void> stop() async => _player.stop();
  Future<void> resume() async => _player.play();

  Future<void> dispose() async {
    await _player.dispose();
  }
}
