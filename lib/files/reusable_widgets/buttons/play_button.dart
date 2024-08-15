import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget playButton(TuneInfo info, {Function()? onTap}) {
  return GenericButton(
    borderColor: red,
    bgColor: white,
    leadingIcon: const Icon(Icons.play_arrow_rounded),
    title: playStr,
    onTap: onTap,
  );
}
