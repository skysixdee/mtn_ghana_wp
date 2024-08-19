import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableRepeatSectionView extends StatelessWidget {
  SelectableRepeatSectionView({super.key});
  final MyTuneSettingController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: con.timeTpe.value == TimeType.timeAndDate
          ? monthlyRepeat()
          : daysRepeat(),
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
          child: GenericButton(
            radius: 4,
            title: con.repeatMonthly[index],
          ),
        );
      },
    );
  }

  Widget daysRepeat() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: con.repeatDays.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GenericButton(
            radius: 4,
            title: con.repeatDays[index],
          ),
        );
      },
    );
  }
}
