import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlayingTuneCard extends StatelessWidget {
  const PlayingTuneCard({super.key, required this.info});
  final ToneDetail info;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: image()),
          tuneInfo(),
        ],
      ),
    );
  }

  Widget image() {
    return customImage(url: info.toneIdpreviewImageUrl);
  }

  Widget tuneInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: info.toneName,
          fontName: FontName.bold,
        ),
        CustomText(
          title: info.artistName,
          color: grey,
        ),
      ],
    );
  }
}
