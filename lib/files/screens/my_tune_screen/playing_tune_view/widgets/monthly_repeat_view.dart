import 'package:etisalat/files/enums/playing_card_type.dart';
import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget monthlyRepeatView(ToneDetail info, SizingInformation si) {
  List<String> repeat = [noneStr, monthlyStr, yearlyStr];
  return SizedBox(
    height: 32,
    child: ListView.builder(
      itemCount: repeat.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _color(info, repeat[index]),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Center(
                child: CustomText(
                  title: repeat[index],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Color _color(ToneDetail info, String title) {
  if (title.toLowerCase() == info.playingCardType?.name) {
    return yellow;
  } else {
    return lightGrey;
  }
}
