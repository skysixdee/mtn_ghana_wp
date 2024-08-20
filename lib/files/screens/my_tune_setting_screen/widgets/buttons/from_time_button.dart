import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget fromTimeButton(MyTuneSettingController con) {
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
                    title: startTimeStr,
                    color: grey,
                    fontSize: 12,
                  ),
                  CustomText(
                    title: con.timeType.value == TimeType.time
                        ? '07:53'
                        : '19/08/2024, 07:53',
                    fontSize: 12,
                    fontName: FontName.bold,
                  ),
                ],
              ),
              onTap: () {
                print("start time tapped");
              },
            );
    },
  );
}
