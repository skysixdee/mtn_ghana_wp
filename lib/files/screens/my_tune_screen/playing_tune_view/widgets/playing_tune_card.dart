import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/controllers/player_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/enums/playing_card_type.dart';
import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/my_tune_screen/playing_tune_view/widgets/day_repeat_view.dart';
import 'package:etisalat/files/screens/my_tune_screen/playing_tune_view/widgets/monthly_repeat_view.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlayingTuneCard extends StatelessWidget {
  PlayingTuneCard({super.key, required this.info});
  final MyPlayingTuneController con = Get.find();
  PlayerController pCont = Get.find();
  final ToneDetail info;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: image()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: infoBuilder(),
          ),
        ],
      ),
    );
  }

  Widget infoBuilder() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tuneInfo(si),
            verticalDivider(),
            statusWidget(si),
            verticalDivider(),
            timeWidget(si),
            verticalDivider(),
            repeatView(si),
          ],
        );
      },
    );
  }

  Widget repeatView(SizingInformation si) {
    return ((info.playingCardType == PlayingCardType.none) ||
            (info.playingCardType == PlayingCardType.monthly) ||
            (info.playingCardType == PlayingCardType.yearly))
        ? monthlyRepeatView(info, si)
        : dayRepeatView(info, si);
  }

  Widget verticalDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(height: 1, color: lightGrey),
    );
  }

  Widget image() {
    return customImage(url: info.toneIdpreviewImageUrl);
  }

  Widget tuneInfo(SizingInformation si) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: nameAndArtist(si)),
        const SizedBox(width: 8),
        playButton(),
        const SizedBox(width: 6),
        deleteButton(),
      ],
    );
  }

  Widget playButton() {
    return Obx(
      () {
        return GenericButton(
          isStopPlay: false,
          padding: EdgeInsets.zero,
          bgColor: yellow,
          height: 34,
          width: 34,
          radius: 17,
          leadingIcon: Icon(
            pCont.playingToneId.value == info.toneId
                ? Icons.pause
                : Icons.play_arrow_rounded,
            size: pCont.playingToneId.value == info.toneId ? 20 : 22,
            color: white,
          ),
          onTap: () {
            TuneInfo inf = TuneInfo(
              toneIdStreamingUrl: info.toneIdStreamingUrl ?? "",
              toneId: info.toneId,
              artistName: info.albumName,
              albumName: info.albumName,
              categoryId: '',
            );
            print("info.toneUrl ${inf.toneUrl}");
            print("info.toneIdStreamingUrl ${inf.toneIdStreamingUrl}");
            pCont.playUrl(inf);
          },
        );
      },
    );
    // Container(
    //   height: 34,
    //   width: 34,
    //   decoration:
    //       BoxDecoration(borderRadius: BorderRadius.circular(17), color: yellow),
    //   child:
    //const Icon(
    //     Icons.play_arrow_rounded,
    //     color: white,
    //   ),
    // );
  }

  Widget deleteButton() {
    return GenericButton(
      bgColor: white,
      width: 34,
      height: 34,
      borderColor: red,
      padding: EdgeInsets.zero,
      leadingIcon: const Icon(
        Icons.delete_forever_outlined,
        color: red,
        size: 20,
      ),
      onTap: () {
        con.deleteTune(info);
      },
    );
  }

  Column nameAndArtist(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: info.toneName, fontName: FontName.bold, maxLine: 1),
        CustomText(title: info.artistName, color: grey, maxLine: 1),
      ],
    );
  }

  Widget statusWidget(SizingInformation si) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textColumn(
            statusStr, con.isShuffleOn.value ? shuffleStr : activeStr, si),
        textColumn(callerStr, serviceName(), si,
            crossAxisAlignment: CrossAxisAlignment.center),
        textColumn(playAtStr, playAt(), si,
            crossAxisAlignment: CrossAxisAlignment.end),
      ],
    );
  }

  Widget timeWidget(SizingInformation si) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textColumn(startTimeStr, fromDate(info), si),
        textColumn(endTimeStr, toDate(info), si,
            crossAxisAlignment: CrossAxisAlignment.end),
      ],
    );
  }

  String serviceName() {
    if (info.serviceName == 'AllCaller') {
      return allStr;
    } else if (info.serviceName == 'SpecialCallerSetting') {
      return info.bParty ?? '';
    } else {
      return "Check Here";
    }
  }

  String playAt() {
    if (info.playingCardType == PlayingCardType.customTime) {
      return customTimeStr;
    } else if (info.playingCardType == PlayingCardType.fullday) {
      return fullDayStr;
    } else if (info.playingCardType == PlayingCardType.monthly) {
      return monthlyStr;
    } else if (info.playingCardType == PlayingCardType.yearly) {
      return yearlyStr;
    } else {
      return noneStr;
    }
  }

  Widget textColumn(
    String title,
    String subTitle,
    SizingInformation si, {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CustomText(
          title: title,
          color: grey,
        ),
        CustomText(
          title: subTitle,
        ),
      ],
    );
  }

  String fromDate(ToneDetail info1) {
    if (info1.playingCardType == PlayingCardType.yearly) {
      return "${info1.yearlyStartDay}/${info1.yearlyStartMonth}, ${getCustomTime(info1.yearlyStartTime ?? "")}";
    } else if (info1.playingCardType == PlayingCardType.monthly) {
      return "${getDayOfSuffix(int.parse(info1.startDayMonthly ?? '0'))}, ${getCustomTime(info1.startTimeMonthly ?? "")}";
    } else if (info1.playingCardType == PlayingCardType.none) {
      return "${customDate(info1.customiseStartDate ?? "")}, ${getCustomTime(info1.customiseStartTime ?? "")}";
    } else if (info1.playingCardType == PlayingCardType.fullday) {
      return "00:00";
    } else {
      return getCustomTime(info1.startTimeWeekly ?? "");
    }
  }

  String toDate(ToneDetail info) {
    ToneDetail? info1 = info; //toneDetails?.first;

    if (info1.playingCardType == PlayingCardType.yearly) {
      return "${info1.yearlyEndDay}/${info1.yearlyEndMonth}, ${getCustomTime(info1.yearlyEndTime ?? "")}";
    } else if (info1.playingCardType == PlayingCardType.monthly) {
      return "${getDayOfSuffix(int.parse(info1.endDayMonthly ?? '0'))}, ${getCustomTime(info1.endTimeMonthly ?? "")}";
    } else if (info1.playingCardType == PlayingCardType.none) {
      return "${customDate(info1.customiseEndDate ?? "")}, ${getCustomTime(info1.customiseEndTime ?? "")}";
    } else if (info1.playingCardType == PlayingCardType.fullday) {
      return "23:59";
    } else {
      return getCustomTime(info1.endTimeWeekly ?? "");
    }
  }

  String getDayOfSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return '${dayNum}th Day';
    }

    switch (dayNum % 10) {
      case 1:
        return '${dayNum}st Day';
      case 2:
        return '${dayNum}nd Day';
      case 3:
        return '${dayNum}rd Day';
      default:
        return '${dayNum}th Day';
    }
  }

  String getCustomTime(String time) {
    List<String> list = time.split(":");
    return "${list[0]}:${list[1]}";
  }

  int repeatYearlySelectedType(ToneDetail info) {
    ToneDetail? info1 = info; //.toneDetails?.first;
    if (info1.playingCardType == PlayingCardType.monthly) {
      return 1;
    } else if (info1.playingCardType == PlayingCardType.yearly) {
      return 2;
    } else if (info1.playingCardType == PlayingCardType.none) {
      return 0;
    } else {
      return -1;
    }
  }

  String customDate(String date) {
    List<String> lst = date.split('-');
    return "${lst[2]}/${lst[1]}/${lst[0]}";
  }
}
