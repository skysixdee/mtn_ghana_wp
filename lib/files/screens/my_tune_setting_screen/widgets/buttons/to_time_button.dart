import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/enums/time_type.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget toTimeButton(MyTuneSettingController con) {
  return Obx(
    () {
      return con.timeType.value == TimeType.fullday
          ? const SizedBox()
          : GenericButton(
              padding: const EdgeInsets.only(right: 60, left: 12),
              height: 50,
              radius: 2,
              bgColor: white,
              leadingIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: endTimeStr,
                    fontSize: 12,
                    color: grey,
                  ),
                  Obx(
                    () {
                      return CustomText(
                        title: con.endTimeStr.value,
                        fontSize: 12,
                        fontName: FontName.bold,
                      );
                    },
                  ),
                ],
              ),
              onTap: () {
                con.toPicker();
              },
            );
    },
  );
}
