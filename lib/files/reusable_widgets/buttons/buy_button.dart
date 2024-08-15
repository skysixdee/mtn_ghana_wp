import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

Widget buyButton(TuneInfo info) {
  return GenericButton(
    title: buyStr,
    leadingIcon: const Icon(Icons.card_travel, size: 16),
    bgColor: yellow,
    onTap: () {},
  );
}
