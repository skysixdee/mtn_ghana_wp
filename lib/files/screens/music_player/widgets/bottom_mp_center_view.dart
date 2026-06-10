import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/mp_play_button.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';

class BottomMpCenterView extends StatelessWidget {
  const BottomMpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        GenericButton(
          bgColor: transparent,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          width: 40,
          leadingIcon: const Icon(
            Icons.skip_previous_rounded,
            color: white,
          ),
          onTap: () {
            // final currentIndex = pCont.currentIndex.value;
            // final nextIndex = (currentIndex - 1) % pCont.tuneList.length;
            // final nextTune = pCont.tuneList[nextIndex];
            // pCont.playUrl(nextTune);
            pCont.playPrevious();
          },
        ),
        MpPlayButton(
          tuneList: pCont.tuneList,
          tuneInfo: pCont.toneinfo.value,
          bgColor: transparent,
          playColor: white,
          padding: EdgeInsets.zero,
          width: 40,
        ),
        GenericButton(
          bgColor: transparent,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          width: 40,
          leadingIcon: const Icon(
            Icons.skip_next_rounded,
            color: white,
          ),
          onTap: () {
            print("tapped next button");
            pCont.playNext();
          },
        )
      ],
    );
  }

  Icon isPlayingThis() {
    final isThisSong =
        pCont.playingUrl.value == pCont.toneinfo.value.toneIdStreamingUrl;

    // Loading state — check this FIRST, independent of isPlaying
    if (isThisSong && pCont.isLoading.value) {
      return const Icon(Icons.hourglass_top_rounded, size: 16);
    }

    // This song is playing
    if (isThisSong && pCont.isPlaying.value) {
      return const Icon(Icons.pause_rounded, size: 20);
    }

    // This song is paused
    if (isThisSong && pCont.isPaused.value) {
      return const Icon(Icons.play_arrow_rounded, size: 20);
    }

    // Default — not this song
    return const Icon(Icons.play_arrow_rounded, size: 20);
  }
}
