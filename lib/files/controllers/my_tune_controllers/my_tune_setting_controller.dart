import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class MyTuneSettingController extends GetxController {
  List<String> repeatDays = ['S', 'M', 'T', 'W', 'Th', 'F', 'S'];
  List<String> repeatMonthly = [noneStr, monthlyStr, yearlyStr];
  Rx<TimeType> timeTpe = TimeType.timeAndDate.obs;
}
