import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MpAudioPlayer {
  static final MpAudioPlayer instance = MpAudioPlayer._internal();
  late AudioPlayer _player;
  String playingUrl = '';
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  MpAudioPlayer._internal() {
    _player = AudioPlayer();
  }

  factory MpAudioPlayer() {
    return instance;
  }

  // Expose the stream — controller will listen to this
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  playUrl(String url, Function(bool)? isPlaying) async {
    try {
      await _player.setUrl(url);
      play();
      isPlaying?.call(true);
      playingUrl = url;
      print("SKY Playing URL: $url");
    } on PlayerException catch (e) {
      print("SKY Error code: ${e.code}");

      snackBar("${e.message}\n$errorPlayingTuneStr");
      print("SKY Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("SKY Connection aborted: ${e.message}");
      snackBar("${e.message}\n$errorPlayingTuneStr");
    } catch (e) {
      print('SKY An error occured: $e');
      snackBar(errorPlayingTuneStr);
    }
  }

  playerSeek(Duration position) async => _player.seek(position);
  Future<void> play() async => _player.play();
  Future<void> pause() async => _player.pause();
  Future<void> stop() async => _player.stop();
  Future<void> resume() async => _player.play();
}
