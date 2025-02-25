import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:mtn_ghana_wp/files/enums/caller_type.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

Widget whomSelectionView(MyTuneSettingController con) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: whomYouWantToPlayItStr,
        fontName: FontName.bold,
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () => con.updateCallerType(CallerType.allCaller),
              child: _radioButton(con, CallerType.allCaller, allCallerStr)),
          const SizedBox(width: 40),
          InkWell(
              onTap: () => con.updateCallerType(CallerType.dedicated),
              child: _radioButton(con, CallerType.dedicated, specialCallerStr)),
          // const SizedBox(width: 40),
          // InkWell(
          //     onTap: () => con.updateCallerType(CallerType.shuffle),
          //     child: _radioButton(con, CallerType.dedicated, specialCallerStr)),
        ],
      ),
    ],
  );
}

Widget _radioButton(
    MyTuneSettingController con, CallerType type, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Obx(
      () {
        return Row(
          children: [
            Icon(
                con.callerType.value == type
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 18),
            CustomText(
              title: title,
              fontName: con.callerType.value == type
                  ? FontName.bold
                  : FontName.regular,
            )
          ],
        );
      },
    ),
  );
}
