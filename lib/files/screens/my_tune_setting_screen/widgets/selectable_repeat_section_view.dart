import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/model/repeat_day_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableRepeatSectionView extends StatelessWidget {
  SelectableRepeatSectionView({super.key});
  final MyTuneSettingController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Obx(
        () {
          return con.timeType.value == TimeType.timeAndDate
              ? monthlyRepeat()
              : daysRepeat(MediaQuery.of(context).size.width < 1000);
        },
      ),
    );
  }

  Widget monthlyRepeat() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: con.repeatMonthly.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Obx(
            () {
              return GenericButton(
                bgColor:
                    con.repeatMonthly[index].isSelected.value ? yellow : white,
                radius: 4,
                title: con.repeatMonthly[index].title,
                onTap: () {
                  con.updateMonthlySelection(con.repeatMonthly[index]);
                  // repeatMonthly[index].isSelected.value =
                  //     !con.repeatMonthly[index].isSelected.value;
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget daysRepeat(bool isSort) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: con.repeatDaysF.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Obx(
              () {
                RepeatDayModel info = con.repeatDaysF[index];
                return GenericButton(
                  padding: EdgeInsets.symmetric(horizontal: isSort ? 16 : 8),
                  bgColor:
                      con.repeatDaysF[index].isSelected.value ? yellow : white,
                  radius: 4,
                  fontSize: isSort ? 12 : 12,
                  title: isSort ? info.titleSort : info.titleFull,
                  onTap: () {
                    con.repeatDaysF[index].isSelected.value =
                        !con.repeatDaysF[index].isSelected.value;
                  },
                );
              },
            ));
      },
    );
  }
}
