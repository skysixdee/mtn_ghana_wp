import 'package:etisalat/files/enums/caller_type.dart';
import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/model/repeat_day_model.dart';
import 'package:etisalat/files/model/repeat_monthly_model.dart';
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
}
