import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';

class MpSlider extends StatelessWidget {
  MpSlider({super.key});

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            if (pCont.isPlaying.value)
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0.2,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 5),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 5),
                  activeTrackColor: white,
                  inactiveTrackColor: white,
                  thumbColor: Colors.white,
                  //overlayColor: Colors.black.withOpacity(0.7),
                ),
                child: Slider(
                  value: pCont.sliderValue.value.clamp(0.0, 1.0),
                  onChangeStart: (_) => pCont.isSeeking.value = true,
                  onChanged: (value) => pCont.sliderValue.value = value,
                  onChangeEnd: (value) => pCont.seekTo(value),
                ),
              ),
          ],
        ));
  }
}
