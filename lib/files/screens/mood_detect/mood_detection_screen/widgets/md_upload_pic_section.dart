import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/camera_screen.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_chip_model.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/moods_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MdUploadPicSection extends StatelessWidget {
  MdUploadPicSection({super.key});
  final MoodsController con = Get.find();

  void _openCamera() {
    con.mood.value = '';
    if (!con.modelsReady.value) return;

    genericPopup(
      Container(
        color: Colors.black,
        child: Center(
          child: ResponsiveBuilder(
            builder: (context, si) {
              return SizedBox(
                width: si.isMobile ? 350 : 500,
                height: si.isMobile ? 440 : 600,
                child: const CameraScreen(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ResponsiveBuilder(
        builder: (context, si) {
          return si.isMobile
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: si.isMobile ? 8 : 24,
                    vertical: si.isMobile ? 16 : 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mainColumn(si),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(child: mainColumn(si)),
                );
        },
      ),
    );
  }

  Column mainColumn(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        headerTitle(si),
        SizedBox(height: si.isMobile ? 40 : 20),
        noFaceYet(si),
        const SizedBox(height: 8),
        detectYourMoodToGetPersonalize(si),
        SizedBox(height: si.isMobile ? 40 : 20),
        instructionView(si),
        SizedBox(height: si.isMobile ? 40 : 20),
        Column(
          spacing: 8,
          children: [
            startDetectionButton(),
            uploadButton(),
          ],
        ),
        if (si.isMobile)
          Obx(
            () {
              return con.moodChipList.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 40),
                        chipSection(si),
                      ],
                    )
                  : const SizedBox.shrink();
            },
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
                colorD: black,
                color: black,
                fontName: FontName.semiBold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chipSection(SizingInformation si) {
    return Column(
      spacing: 12,
      children: [
        orPicWidget(si),
        moodListWidget(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: selectedMoodChipInstantWidget(),
        ),
      ],
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
              children: [for (var chip in con.moodChipList) chipCard(chip)]
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
          trailingIcon: const SizedBox(
            width: 4,
          ),
          leadingIcon: Padding(
              padding: const EdgeInsetsGeometry.directional(end: 2.0),
              child: SizedBox(
                  height: 16,
                  width: 16,
                  child:
                      customImage(url: moodChipModel.image, cornerRadius: 8))),
          onTap: () {
            print("taped at ${moodChipModel.title}");
            //con.getMoodToneList(moodChipModel.title);
            con.getMoodListOnChipTap(moodChipModel.title, moodChipModel.id);
          },
          title: moodChipModel.title,
        ),
      ],
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

  Widget headerTitle(SizingInformation si) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            CustomText(
              title: unlimeitedTonesStr,
              fontName: FontName.semiBold,
              fontSize: si.isMobile ? 11 : 10,
            ),
            CustomText(
              title: moodDetectStr,
              fontName: FontName.bold,
              fontSize: si.isMobile ? 18 : 22,
            ),
          ],
        ),
      ],
    );
  }

  Widget instructionView(SizingInformation si) {
    return Obx(
      () {
        return con.imageBytes.value != null
            ? CustomText(
                textAlign: TextAlign.center,
                title: youAreLookindStr.replaceAll(
                  "MOOD",
                  con.mood.value,
                ),
                fontName: FontName.semiBold,
                fontSize: 12,
              )
            : Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  instructionChip(si, "1", allowCamOrUploadPhotoStr),
                  instructionChip(si, "2", weAnalizeYrFacialStr),
                  instructionChip(si, "3", getMusicMatchStr),
                ],
              );
      },
    );
  }

  Widget noFaceYet(SizingInformation si) {
    return Container(
      //clipBehavior: Clip.hardEdge,
      height: 160,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(
              color: appCont.isDarkTheme.value ? whiteD : lightGrey)),
      child: Obx(
        () {
          return con.imageBytes.value != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      child: Image.memory(
                        height: 180, //si.isMobile ? 100 : 200,
                        width: 180, //si.isMobile ? 100 : 200,
                        con.imageBytes.value!,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    closeButton()
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () {
                          return Icon(
                            Icons.face_outlined,
                            color: appCont.isDarkTheme.value ? whiteD : black,
                          );
                        },
                      ),
                      CustomText(
                        title: noFaceYetStr,
                        color: grey,
                        fontName: FontName.regular,
                        fontSize: si.isMobile ? 11 : 12,
                        colorD: whiteD,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget closeButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: GenericButton(
            height: 36,
            width: 36,
            radius: 2,
            padding: EdgeInsets.zero,
            leadingIcon: const Icon(
              Icons.close,
              size: 18,
            ),
            onTap: () {
              con.imageBytes.value = null;
              con.mood.value = "";
            },
          ),
        )
      ],
    );
  }

  Widget detectYourMoodToGetPersonalize(SizingInformation si) {
    return Obx(
      () {
        return con.imageBytes.value != null
            ? Container(
                decoration: BoxDecoration(
                    color: lightYellow,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                  child: CustomText(
                    colorD: blackD,
                    fontName: FontName.bold,
                    fontSize: si.isMobile ? 12 : 13,
                    title: moodDetectedStr
                        .replaceAll("MOOD", con.mood.value)
                        .toUpperCase(),
                  ),
                ),
              )
            : SizedBox(
                width: 300,
                child: CustomText(
                  title: tuneYourEmotionIntoStr,
                  colorD: whiteD,
                  textAlign: TextAlign.center,
                  fontName: FontName.semiBold,
                  fontSize: si.isMobile ? 12 : 13,
                ),
              );
      },
    );
  }

  Widget instructionChip(SizingInformation si, String index, String title) {
    return Container(
      decoration: BoxDecoration(
          color: lightGrey,
          border: Border.all(color: lightYellow),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            GenericButton(
              textColorD: blackD,
              height: 26,
              width: 26,
              title: index,
              fontSize: si.isMobile ? 10 : 11,
              padding: EdgeInsets.zero,
              bgColor: lightYellow,
            ),
            Flexible(
              child: CustomText(
                colorD: blackD,
                title: title,
                fontSize: si.isMobile ? 12 : 13,
                fontName: FontName.semiBold,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget startDetectionButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: GenericButton(
              textColorD: blackD,
              leadingIcon: const Padding(
                padding: EdgeInsetsGeometry.directional(end: 4.0),
                child: Icon(
                  Icons.camera,
                  size: 17,
                ),
              ),
              width: 300,
              title: startDetectStr,
              fontSize: 12,
              onTap: _openCamera),
        ),
      ],
    );
  }

  Widget uploadButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: GenericButton(
            fontSize: 12,
            textColorD: blackD,
            leadingIcon: const Padding(
              padding: EdgeInsetsGeometry.directional(end: 4.0),
              child: Icon(
                Icons.upload_outlined,
                size: 18,
              ),
            ),
            width: 300,
            title: uploadPictureStr,
            onTap: () {
              con.pickImage();
            },
          ),
        ),
      ],
    );
  }
}
