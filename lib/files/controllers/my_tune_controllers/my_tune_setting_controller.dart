import 'package:etisalat/files/api_calls/get_pack_detail_api.dart';
import 'package:etisalat/files/api_calls/tune_setting_api/tune_setting_dedicated_api.dart';
import 'package:etisalat/files/api_calls/tune_setting_api/tune_setting_fullday_api.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/model/pack_detail_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/model/tune_setting_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:get/get.dart';
import 'package:etisalat/files/enums/time_type.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:etisalat/files/enums/caller_type.dart';
import 'package:etisalat/files/model/repeat_day_model.dart';
import 'package:etisalat/files/model/repeat_monthly_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_snack_bar.dart';
import 'package:etisalat/files/reusable_widgets/time_date_picker.dart';

class MyTuneSettingController extends GetxController {
  List<RepeatDayModel> repeatDaysF = [
    RepeatDayModel('SUNDAY', 'S', false),
    RepeatDayModel('MONDAY', 'M', false),
    RepeatDayModel('TUESDAY', 'T', false),
    RepeatDayModel('WEDNESDAY', 'W', false),
    RepeatDayModel('THURSDAY', 'Th', false),
    RepeatDayModel('FRIDAY', 'F', false),
    RepeatDayModel('SATURDAY', 'S', false),
  ];
  MyPlayingTuneController playingTuneController = Get.find();
  List<RepeatMonthlyModel> repeatMonthly = [
    RepeatMonthlyModel(noneStr, isSelected: true),
    RepeatMonthlyModel(monthlyStr),
    RepeatMonthlyModel(yearlyStr)
  ];
  RxBool isLoading = false.obs;
  Rx<TimeType> timeType = TimeType.fullday.obs;
  RxString timeTypeTitle = fullDayStr.obs;
  Rx<CallerType> callerType = CallerType.allCaller.obs;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  RxString startTimeStr = ''.obs;
  RxString endTimeStr = ''.obs;
  Function()? onSuccess;
  String msisdn = '';
  String packName = '';
  late TuneInfo info;
  resetValue() {
    packName = '';
    repeatDaysF = [
      RepeatDayModel('SUNDAY', 'S', false),
      RepeatDayModel('MONDAY', 'M', false),
      RepeatDayModel('TUESDAY', 'T', false),
      RepeatDayModel('WEDNESDAY', 'W', false),
      RepeatDayModel('THURSDAY', 'Th', false),
      RepeatDayModel('FRIDAY', 'F', false),
      RepeatDayModel('SATURDAY', 'S', false),
    ];

    repeatMonthly = [
      RepeatMonthlyModel(noneStr, isSelected: true),
      RepeatMonthlyModel(monthlyStr),
      RepeatMonthlyModel(yearlyStr)
    ];
    timeType.value = TimeType.fullday;
    timeTypeTitle.value = fullDayStr;
    callerType.value = CallerType.allCaller;
    var date = DateTime.now();
    startDate = DateTime.now();
    endDate = DateTime(
        date.year, date.month, date.day + 1, date.hour + 1, date.minute);
    startTimeStr.value = '';
    endTimeStr.value = '';
    msisdn = '';
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
    startTimeStr.value = _timeAndDateInString(startDate);
    endTimeStr.value = _timeAndDateInString(endDate);
  }

  updateCallerType(CallerType type) {
    print("caller type = ${type}");
    callerType.value = type;
  }

  updateMsisdn(String value) {
    msisdn = value;
  }

  updateMonthlySelection(RepeatMonthlyModel value) {
    for (var rep in repeatMonthly) {
      rep.isSelected.value = false;
    }
    value.isSelected.value = true;
  }

  //=============== Api call=================

  onConfirmButtonTap(TuneInfo info) async {
    this.info = info;

    print("calle = ${callerType.value}");
    if (!checkAtLeastOneDaySelection()) {
      return false;
    }
    if (!isValidTimeDifference()) {
      //customSnackBar(timeDifferenceErrorStr);
      popupAlert(timeDifferenceErrorStr);
      return false;
    }
    if (callerType.value == CallerType.dedicated) {
      if (packName.isEmpty) {
        PackDetailModel packDetailModel = await getPackDetailApi();
        packName =
            (packDetailModel.responseMap?.packStatusDetails?.packName ?? '');
      }
      if (packName.isEmpty) {
        openAlertPopup(message: invalidPackNameStr);
        return;
      }
      if (msisdn.isEmpty) {
        //customSnackBar(enterFriendMobileNumberStr);
        popupAlert(enterFriendMobileNumberStr);
        return false;
      }
    }

    if (callerType.value == CallerType.allCaller) {
      if (timeType.value == TimeType.time) {
        timeBaseAllCallerSetting();
      } else if (timeType.value == TimeType.timeAndDate) {
        timeAndDateAllCallerdSetting();
      } else {
        fullDayAllCallerSetting();
      }
    } else {
      if (packName.isEmpty) {
        popupAlert(invalidPackNameStr);
        return;
      }
      if (timeType.value == TimeType.time) {
        timeBaseDedicatedSetting();
      } else if (timeType.value == TimeType.timeAndDate) {
        timeAndDateDedicatedSetting();
      } else {
        fullDayDedicatedSetting();
      }
    }
  }

  bool checkAtLeastOneDaySelection() {
    if (timeType.value != TimeType.timeAndDate) {
      bool isSelected = false;
      for (var element in repeatDaysF) {
        if (element.isSelected.value) {
          isSelected = true;
        }
      }
      if (!isSelected) {
        //customSnackBar(selectAtleasrOneDayStr);
        popupAlert(selectAtleasrOneDayStr);
        return false;
      }
    }
    return true;
  }

  popupAlert(String message) {
    print("pop up alert $message");
    openAlertPopup(message: message);
    //Get.dialog(genericPopover(context, menuList))
  }

  bool isValidTimeDifference() {
    if (timeType.value == TimeType.time) {
      DateTime d = DateTime.now();
      DateTime sdt =
          DateTime(d.year, d.month, d.day, startDate.hour, startDate.minute);
      DateTime edt =
          DateTime(d.year, d.month, d.day, endDate.hour, endDate.minute);
      int difference = (edt).difference(sdt).inMinutes;
      print("difference is $difference");
      return difference >= 1;
    } else if (timeType.value == TimeType.timeAndDate) {
      int difference = (endDate).difference(startDate).inMinutes;
      print("difference is $difference");
      return difference >= 1;
    } else {
      return true;
    }
  }

  fromPicker() {
    Get.dialog(
        barrierDismissible: false,
        TimeDatePicker(
          dateTime: startDate,
          onConfirm: (p0) {
            startDate = p0;
            startTimeStr.value = _timeAndDateInString(p0);
          },
          onlyTime: timeType.value == TimeType.time,
        ));
  }

  toPicker() {
    Get.dialog(
        barrierDismissible: false,
        TimeDatePicker(
          dateTime: endDate,
          onConfirm: (p0) {
            endDate = p0;
            endTimeStr.value = _timeAndDateInString(p0);
          },
          onlyTime: timeType.value == TimeType.time,
        ));
  }

  String _timeAndDateInString(DateTime t) {
    String h = "${t.hour}".padLeft(2, '0');
    String m = "${t.minute}".padLeft(2, '0');
    String d = "${t.day}".padLeft(2, '0');
    String mo = "${t.month}".padLeft(2, '0');
    String y = "${t.year}";

    String time =
        timeType.value == TimeType.time ? "$h:$m" : "$d/$mo/$y, $h:$m";
    return time;
  }

  Future<String> getSelectedDays() async {
    List<String> daysList = [];
    print("Day count ======= ${repeatDaysF.length}");
    for (var i = 0; i < (repeatDaysF.length); i++) {
      print("repeatDaysF1 ======= ${i}");
      print("repeatDaysF2 ======= ${repeatDaysF[i].isSelected}");

      if (repeatDaysF[i].isSelected.value) {
        daysList.add("${i + 1}");
      }
    }

    print("selected days = ${daysList.join(',')}");
    return daysList.join(',');
  }

  int getSelectedMonthly() {
    int selectedIndex = 0;
    for (var i = 0; i < repeatMonthly.length; i++) {
      if (repeatMonthly[i].isSelected.value) {
        selectedIndex = i;
      }
    }

    print("selected monthly = $selectedIndex");
    return selectedIndex;
  }

  fullDayAllCallerSetting() async {
    isLoading.value = true;
    String days = await getSelectedDays();
    TuneSettingModel model = await fulldayApi(days, info.toneId ?? '');

    if (model.statusCode == "SC0000") {
      onSucessApiCall();
    } else {
      customSnackBar(model.message);
    }
    isLoading.value = false;
    print("Full day All Caller setting");
  }

  timeBaseAllCallerSetting() async {
    isLoading.value = true;
    String days = await getSelectedDays();
    TuneSettingModel model =
        await fulldayTimeBaseApi(days, info.toneId ?? '', startDate, endDate);

    if (model.statusCode == "SC0000") {
      onSucessApiCall();
    } else {
      customSnackBar(model.message);
    }
    isLoading.value = false;
    print("Time base  All Caller setting");
  }

  timeAndDateAllCallerdSetting() async {
    isLoading.value = true;
    TuneSettingModel model = TuneSettingModel();
    if (getSelectedMonthly() == 1) {
      model = await fulldayRepeatBaseMonthlyApi(
          info.toneId ?? '', startDate, endDate);
    } else if (getSelectedMonthly() == 2) {
      model = await fulldayRepeatBaseYearlyApi(
          info.toneId ?? '', startDate, endDate);
    } else {
      model =
          await fulldayRepeatBaseNoneApi(info.toneId ?? '', startDate, endDate);
    }

    if (model.statusCode == "SC0000") {
      onSucessApiCall();
    } else {
      customSnackBar(model.message);
    }
    isLoading.value = false;
    print("Time And Date base  All Caller setting");
  }

  fullDayDedicatedSetting() async {
    isLoading.value = true;
    String days = await getSelectedDays();
    TuneSettingModel model =
        await fulldayDedicatedApi(info.toneId ?? '', msisdn, packName, days);
    if (model.statusCode == "SC0000") {
      onSucessApiCall();
    } else {
      customSnackBar(model.message);
    }
    isLoading.value = false;
    print("Full day Dedicated setting");
  }

  timeBaseDedicatedSetting() async {
    isLoading.value = true;
    String days = await getSelectedDays();
    TuneSettingModel model = await fulldayTimeBaseDedicatedApi(
        info.toneId ?? '', msisdn, packName, days, startDate, endDate);
    if (model.statusCode == "SC0000") {
      onSucessApiCall();
    } else {
      customSnackBar(model.message);
    }
    isLoading.value = false;
    print("Time base Dedicated setting");
  }

  timeAndDateDedicatedSetting() async {
    isLoading.value = true;
    TuneSettingModel model = TuneSettingModel();
    if (getSelectedMonthly() == 1) {
      model = await fulldayRepeatBaseNoneDedicatedApi(
          info.toneId ?? '', msisdn, packName, startDate, endDate);
    } else if (getSelectedMonthly() == 2) {
      model = await fulldayRepeatBaseYearlyDedicatedApi(
          info.toneId ?? '', msisdn, packName, startDate, endDate);
    } else {
      model = await fulldayRepeatBaseNoneDedicatedApi(
          info.toneId ?? '', msisdn, packName, startDate, endDate);
    }
    if (model.statusCode == "SC0000") {
      onSucessApiCall();
    } else {
      customSnackBar(model.message);
    }
    isLoading.value = false;
    print("Time and date base Dedicated setting");
  }

  onSucessApiCall() {
    openAlertPopup(
      message: tuneIsLiveStr,
      onPrimary: () {
        playingTuneController.getPlayingTune();
        if (onSuccess != null) {
          onSuccess!();
        }
      },
    );
  }
}
