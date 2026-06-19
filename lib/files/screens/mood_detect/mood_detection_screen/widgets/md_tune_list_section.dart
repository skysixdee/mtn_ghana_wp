import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/empty_list_widget.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_chip_model.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/moods_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MdTuneListSection extends StatelessWidget {
  MdTuneListSection({super.key});
  final MoodsController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          children: [
            headerView(si),
            Expanded(
              child: Obx(
                () {
                  return cont.isMoodTapped.value
                      ? cont.isLoadingTunes.value
                          ? loadingIndicator(height: 300)
                          : tuneList(si)
                      : cont.imageBytes.value == null
                          ? initalUI(si)
                          : cont.isLoadingTunes.value
                              ? loadingIndicator(height: 300)
                              : tuneList(si);
                },
              ),
            ),
            yourPhotoSupposeWidget()
          ],
        );
      },
    );
  }

  Widget tuneList(SizingInformation si) {
    return Obx(
      () {
        return cont.moodList.isEmpty
            ? emptyListWidget(height: 300, fontSize: si.isMobile ? 16 : 20)
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shrinkWrap: true,
                itemCount: cont.moodList.length,
                itemBuilder: (context, index) {
                  var item = cont.moodList[index];
                  return tuneCard(item, index);
                },
              );
      },
    );
  }

  Padding tuneCard(TuneInfo item, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: appCont.isDarkTheme.value ? blackD : white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: appCont.isDarkTheme.value
                      ? white.withValues(alpha: 0.2)
                      : black.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 2)
            ]),
        child: Row(
          spacing: 4,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  customImage(
                      height: 50,
                      width: 50,
                      cornerRadius: 4,
                      url: item.toneIdpreviewImageUrl),
                  // MpPlayButton(
                  //     padding: const EdgeInsets.all(0),
                  //     radius: 2,
                  //     width: 50,
                  //     playColor: white,
                  //     bgColor: black.withValues(alpha: 0.4),
                  //     tuneList: cont.moodList,
                  //     tuneInfo: cont.moodList[index])
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.toneName,
                    fontName: FontName.bold,
                    fontSize: 12,
                  ),
                  CustomText(
                    title: item.artistName,
                    fontName: FontName.regular,
                    fontSize: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column initalUI(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 20,
      children: [
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            playlistPlaceHolder(),
            noPlayListYet(si),
            onceWeDetect(si),
          ],
        ),
        if (cont.moodChipList.isNotEmpty) chipSection(si),
        if (cont.moodChipList.isNotEmpty) selectedMoodChipInstantWidget(),
      ],
    );
  }

  Widget chipSection(SizingInformation si) {
    return Column(
      spacing: 12,
      children: [
        orPicWidget(si),
        moodListWidget(),
      ],
    );
  }

  Widget playlistPlaceHolder() {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: lightYellow),
          child: const Icon(Icons.playlist_remove),
        )
      ],
    );
  }

  Widget noPlayListYet(SizingInformation si) {
    return CustomText(
      title: noPlayListYetStr,
      fontName: FontName.bold,
      fontSize: si.isMobile ? 16 : 20,
    );
  }

  Widget onceWeDetect(SizingInformation si) {
    return SizedBox(
      width: 300,
      child: CustomText(
        title: onceWeDetectYrMoodStr,
        fontName: FontName.regular,
        textAlign: TextAlign.center,
        fontSize: si.isMobile ? 12 : 13,
      ),
    );
  }

  Widget orPicWidget(SizingInformation si) {
    return SizedBox(
      width: 300,
      child: CustomText(
        title: orPickManuallyStr,
        fontName: FontName.semiBold,
        textAlign: TextAlign.center,
        fontSize: si.isMobile ? 11 : 12,
      ),
    );
  }

  Widget moodListWidget() {
    return SizedBox(
      width: 300,
      child: Obx(
        () {
          return Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: [for (var chip in cont.moodChipList) chipCard(chip)]
              // [
              //   chipCard("Happy"),
              //   chipCard("Sad"),
              //   chipCard("Angry"),
              //   chipCard("Calm"),
              //   chipCard("exited"),
              //   chipCard("Romantic"),
              // ],
              );
        },
      ),
    );
  }

  Widget chipCard(MoodChipModel moodChipModel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GenericButton(
          borderColor: lightYellow,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          textColorD: blackD,
          fontName: FontName.semiBold,
          fontSize: 12,
          trailingIcon: const SizedBox(width: 4),
          leadingIcon: Padding(
              padding: const EdgeInsetsGeometry.directional(end: 2.0),
              child: SizedBox(
                  height: 16,
                  width: 16,
                  child:
                      customImage(url: moodChipModel.image, cornerRadius: 8))),
          onTap: () {
            print(
                "taped at ${moodChipModel.title} and id is ${moodChipModel.id}");
            //cont.getMoodToneList(moodChipModel.title);

            cont.mood.value = moodChipModel.title;
            cont.getMoodListOnChipTap(moodChipModel.title, moodChipModel.id);
          },
          title: moodChipModel.title,
        ),
      ],
    );
  }

  Widget selectedMoodChipInstantWidget() {
    return Container(
      decoration: BoxDecoration(
          color: lightGrey, borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: CustomText(
                title: selectMoodChipStr,
                colorD: blackD,
                fontName: FontName.semiBold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget yourPhotoSupposeWidget() {
    return Column(
      children: [
        Container(
          height: 1,
          color: lightGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CustomText(
                  title: yourPhotoProcessedStr,
                  color: grey,
                  fontName: FontName.regular,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerView(SizingInformation si) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              children: [
                if (si.isMobile)
                  GenericButton(
                    bgColor: transparent,
                    leadingIcon: Icon(
                      Icons.arrow_back,
                      color: appCont.isDarkTheme.value ? white : black,
                    ),
                    onTap: () {
                      cont.imageBytes.value = null;
                      cont.moodList.clear();
                      cont.isMoodTapped.value = false;
                    },
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        return CustomText(
                            title: (cont.imageBytes.value == null &&
                                    !cont.isMoodTapped.value)
                                ? yourPlaylistStr
                                : yourPlaylistStr.replaceAll(
                                    "Your mood", cont.mood.value.toUpperCase()),
                            fontName: FontName.bold,
                            fontSize: si.isMobile ? 14 : 20);
                      },
                    ),
                    Obx(
                      () {
                        return CustomText(
                            title: cont.imageBytes.value != null
                                ? numberTrackCuratedStr.replaceAll(
                                    "NUMBER", "${cont.moodList.length}")
                                : detectYourMoodToFillStr,
                            fontName: FontName.regular,
                            fontSize: si.isMobile ? 12 : 13);
                      },
                    )
                  ],
                ),
                Spacer(),
                Obx(
                  () {
                    return cont.isMoodTapped.value
                        ? GenericButton(
                            title: clearStr,
                            textColorD: blackD,
                            fontName: FontName.semiBold,
                            fontSize: 12,
                            onTap: () {
                              cont.isMoodTapped.value = false;
                              cont.moodList.clear();
                            },
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: lightGrey,
          ),
        ],
      ),
    );
  }
}
