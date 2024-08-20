import 'package:etisalat/files/enums/caller_type.dart';
import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/model/repeat_day_model.dart';
import 'package:etisalat/files/model/repeat_monthly_model.dart';
import 'package:etisalat/files/reusable_widgets/time_date_picker.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class MyTuneSettingController extends GetxController {
  List<RepeatDayModel> repeatDaysF = [
    RepeatDayModel('SUNDAY', 'S'),
    RepeatDayModel('MONDAY', 'M'),
    RepeatDayModel('TUESDAY', 'T'),
    RepeatDayModel('WEDNESDAY', 'W'),
    RepeatDayModel('THURSDAY', 'Th'),
    RepeatDayModel('FRIDAY', 'F'),
    RepeatDayModel('SATURDAY', 'S'),
  ];

  List<RepeatMonthlyModel> repeatMonthly = [
    RepeatMonthlyModel(noneStr, isSelected: true),
    RepeatMonthlyModel(monthlyStr),
    RepeatMonthlyModel(yearlyStr)
  ];
  Rx<TimeType> timeType = TimeType.fullday.obs;
  RxString timeTypeTitle = fullDayStr.obs;
  Rx<CallerType> callerType = CallerType.allCaller.obs;

  resetValue() {
    repeatDaysF = [
      RepeatDayModel('SUNDAY', 'S'),
      RepeatDayModel('MONDAY', 'M'),
      RepeatDayModel('TUESDAY', 'T'),
      RepeatDayModel('WEDNESDAY', 'W'),
      RepeatDayModel('THURSDAY', 'Th'),
      RepeatDayModel('FRIDAY', 'F'),
      RepeatDayModel('SATURDAY', 'S'),
    ];

    repeatMonthly = [
      RepeatMonthlyModel(noneStr, isSelected: true),
      RepeatMonthlyModel(monthlyStr),
      RepeatMonthlyModel(yearlyStr)
    ];
    timeType.value = TimeType.fullday;
    timeTypeTitle.value = fullDayStr;
    callerType.value = CallerType.allCaller;
  }

  updateTimeType(int index) {
    if (index == 2) {
      timeType.value = TimeType.timeAndDate;
      timeTypeTitle.value = selectDateAndTimeStr;
    } else if (index == 1) {
      timeType.value = TimeType.time;
      timeTypeTitle.value = selectTimeStr;
    } else {
      timeType.value = TimeType.fullday;
      timeTypeTitle.value = fullDayStr;
    }
  }

  updateCallerType(CallerType type) {
    callerType.value = type;
  }

  updateMonthlySelection(RepeatMonthlyModel value) {
    for (var rep in repeatMonthly) {
      rep.isSelected.value = false;
    }
    value.isSelected.value = true;
  }

  //=============== Api call=================

  onConfirmButtonTap() {
    if (callerType.value == CallerType.allCaller) {
      if (timeType.value == TimeType.time) {
        timeBaseAllCallerSetting();
      } else if (timeType.value == TimeType.timeAndDate) {
        timeAndDateAllCallerdSetting();
      } else {
        fullDayAllCallerSetting();
      }
    } else {
      if (timeType.value == TimeType.time) {
        timeBaseDedicatedSetting();
      } else if (timeType.value == TimeType.timeAndDate) {
        timeAndDateDedicatedSetting();
      } else {
        fullDayDedicatedSetting();
      }
    }
  }

  fromPicker() {
    if (timeType.value == TimeType.time) {
      print("From Time picker");
      //Get.dialog(timeDatePicker());
    } else {
      //Get.dialog(timeDatePicker());
      print("From Time And Date picker");
    }
  }

  toPicker() {
    if (timeType.value == TimeType.time) {
      print("To Time picker");
      //Get.dialog(timeDatePicker());
    } else {
      //Get.dialog(timeDatePicker());
      print("To Time And Date picker");
    }
  }

  fullDayAllCallerSetting() {
    print("Full day All Caller setting");
  }

  timeBaseAllCallerSetting() {
    print("Time base  All Caller setting");
  }

  timeAndDateAllCallerdSetting() {
    print("Time And Date base  All Caller setting");
  }

  fullDayDedicatedSetting() {
    print("Full day Dedicated setting");
  }

  timeBaseDedicatedSetting() {
    print("Time base Dedicated setting");
  }

  timeAndDateDedicatedSetting() {
    print("Time and date base Dedicated setting");
  }
}
