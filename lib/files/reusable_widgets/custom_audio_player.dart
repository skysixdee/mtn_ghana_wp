import 'package:just_audio/just_audio.dart';
import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';

class CustomAudioPlayer {
  static final CustomAudioPlayer instance = CustomAudioPlayer._internal();
  late AudioPlayer _player;
  CustomAudioPlayer._internal() {
    print("initialize MtnAudioPlayer");

    _player = AudioPlayer();
    audioPosition();
    playerState();
  }
  factory CustomAudioPlayer() {
    return instance;
  }
  Function(int)? maxDuration;
  Function(int)? barPosition;
  Function()? onComplete;
  Function()? idle;
  Function()? loading;
  Function()? buffering;
  Function()? ready;
  Function(MyPlayerState)? myPlayerState;

  Future<void> playUrl(String url) async {
    print("playing url is1 $url");
    await stop();

    await stop();
    try {
      print("playing url is2 $url");
      await _player.setUrl(url);
      await _player.play();

      print("playing url is3 $url");
    } on PlayerException catch (e) {
      print("SKY Error code: ${e.code}");
      print("SKY Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("SKY Connection aborted: ${e.message}");
    } catch (e) {
      print('SKY An error occured: $e');
    }
  }

  audioPosition() {
    _player.durationStream.listen((duration) {
      if (maxDuration != null) maxDuration!(duration?.inMilliseconds ?? 0);
      //print("duration is ${duration?.inSeconds}");
    });

    _player.positionStream.listen((position) {
      if (barPosition != null) barPosition!(position.inMilliseconds);
      //print("position = ${position.inSeconds}");
    });
  }

  playerState() {
    try {
      _player.playerStateStream.listen(
        (state) async {
          // if (state.playing) {
          //   if (myPlayerState != null) myPlayerState!(MyPlayerState.playing);
          // }
          print("SKY State is ${state}");
          switch (state.processingState) {
            case ProcessingState.idle:
              print("ProcessingState.idle");
              if (idle != null) idle!();
              if (myPlayerState != null) myPlayerState!(MyPlayerState.pause);
            case ProcessingState.loading:
              print("ProcessingState.loading");
              if (loading != null) loading!();
            //if (playingState != null) playingState!(MyPlayerState.loading);
            //playingState(MyPlayerState.loading);
            //play("url");
            case ProcessingState.buffering:
              print("ProcessingState.buffering");
              if (buffering != null) buffering!();
              if (myPlayerState != null) myPlayerState!(MyPlayerState.loading);
            case ProcessingState.ready:
              print("ProcessingState.ready");
              if (state.playing) {
                print("Audio is playing");
                if (myPlayerState != null) {
                  myPlayerState!(MyPlayerState.playing);
                }
              } else {
                if (myPlayerState != null) myPlayerState!(MyPlayerState.pause);
                print("Audio is paused");
              }

            //if (myPlayerState != null) myPlayerState!(MyPlayerState.pause);
            //if (playingState != null) playingState!(MyPlayerState.playing);
            //playingState(MyPlayerState.playing);

            case ProcessingState.completed:
              print("ProcessingState.completed");

              if (onComplete != null) onComplete!();
              await Future.delayed(const Duration(milliseconds: 200));
              if (barPosition != null) barPosition!(0);
            //if (playingState != null) playingState!(MyPlayerState.completed);
            //playingState(MyPlayerState.completed);
          }
          // ignore: argument_type_not_assignable_to_error_handler
        },
      );
    } catch (e) {
      print("error si == $e");
    }
  }

  playerSeek(Duration position) async {
    _player.seek(position);
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> resume() async {
    await _player.play();
  }
}
