import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/controller/mp_audio_player.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';

class MpPlayButton extends StatelessWidget {
  MpPlayButton({
    super.key,
    required this.tuneList,
    required this.tuneInfo,
    this.bgColor,
    this.playColor,
    this.width,
    this.padding,
    this.radius,
    this.isMusicBox,
  });
  final List<TuneInfo> tuneList;
  final TuneInfo tuneInfo;
  final Color? bgColor;
  final Color? playColor;
  final double? width;
  final double? radius;
  final bool? isMusicBox;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GenericButton(
          radius: radius,
          padding: padding,
          width: width,
          bgColor: bgColor ?? lightGrey,
          leadingIcon: isPlayingThis(),
          onTap: () {
            if (isMusicBox != null) {
              pCont.isMusicBox.value = isMusicBox!;
            } else {
              pCont.isMusicBox.value = false;
            }
            final isThisSong =
                pCont.playingUrl.value == tuneInfo.toneIdStreamingUrl;

            if (isThisSong && pCont.isPlaying.value) {
              MpAudioPlayer.instance
                  .pause(); // stream updates isPaused automatically
              return;
            }

            if (isThisSong && pCont.isPaused.value) {
              MpAudioPlayer.instance
                  .resume(); // stream updates isPlaying automatically
              return;
            }

            // New song
            pCont.isMusicPlayerOpen.value = true;
            pCont.tuneList.value = tuneList;
            pCont.playUrl(tuneInfo);
          },
        );
      },
    );
  }

  Icon isPlayingThis() {
    final isThisSong = pCont.playingUrl.value == tuneInfo.toneIdStreamingUrl;

    // Loading state — check this FIRST, independent of isPlaying
    if (isThisSong && pCont.isLoading.value) {
      return Icon(
        Icons.hourglass_top_rounded,
        size: 16,
        color: playColor ?? black,
      );
    }

    // This song is playing
    if (isThisSong && pCont.isPlaying.value) {
      return Icon(
        Icons.pause_rounded,
        size: 20,
        color: playColor ?? black,
      );
    }

    // This song is paused
    if (isThisSong && pCont.isPaused.value) {
      return Icon(
        Icons.play_arrow_rounded,
        size: 20,
        color: playColor ?? black,
      );
    }

    // Default — not this song
    return Icon(
      Icons.play_arrow_rounded,
      size: 20,
      color: playColor ?? black,
    );
  }
}
