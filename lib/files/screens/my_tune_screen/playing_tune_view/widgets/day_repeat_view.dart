import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

Widget dayRepeatView(ToneDetail info) {
  List<String> days = ['S', 'M', 'T', 'W', 'Th', 'F', 'S'];
  return SizedBox(
    height: 30,
    child: ListView.builder(
      itemCount: days.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: _dayButton(index, info, days[index]),
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
