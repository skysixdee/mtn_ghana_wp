import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class MyTuneSettingController extends GetxController {
  List<String> repeatDays = ['S', 'M', 'T', 'W', 'Th', 'F', 'S'];
  List<String> repeatMonthly = [noneStr, monthlyStr, yearlyStr];
  Rx<TimeType> timeTpe = TimeType.fullday.obs;
  RxString timeTypeTitle = fullDayStr.obs;
  updateTimeType(int index) {
    if (index == 2) {
      timeTpe.value = TimeType.timeAndDate;
      timeTypeTitle.value = selectDateAndTimeStr;
    } else if (index == 1) {
      timeTpe.value = TimeType.time;
      timeTypeTitle.value = selectTimeStr;
    } else {
      timeTpe.value = TimeType.fullday;
      timeTypeTitle.value = fullDayStr;
    }
  }
}
