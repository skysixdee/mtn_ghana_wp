import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/model/my_playing_tunes_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget dayRepeatView(ToneDetail info, SizingInformation si) {
  List<String> days = ['', 'S', 'M', 'T', 'W', 'Th', 'F', 'S'];
  return SizedBox(
    height: 30,
    child: ListView.builder(
      itemCount: days.length - 1,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: _dayButton(index + 1, info, days[index + 1]),
        );
      },
    ),
  );
}

Widget _dayButton(int index, ToneDetail info, String day) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: (info.weeklyDays ?? '').contains('$index') ? yellow : lightGrey),
    child: Center(
      child: CustomText(
        title: day,
      ),
    ),
  );
}
