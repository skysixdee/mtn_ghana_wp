import 'package:etisalat/files/controllers/mobile_tune_preview_cotroller.dart';
import 'package:etisalat/files/controllers/player_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/buy_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileTunePreviewSceen extends StatefulWidget {
  const MobileTunePreviewSceen(
      {super.key, required this.tuneInfo, required this.tuneList});
  final TuneInfo tuneInfo;
  final List<TuneInfo> tuneList;
  @override
  State<MobileTunePreviewSceen> createState() => _MobileTunePreviewSceenState();
}

class _MobileTunePreviewSceenState extends State<MobileTunePreviewSceen> {
  int playingIndex = 0;
  late MobileTunePreviewCotroller con;
  PlayerController pCont = Get.find();
  @override
  void initState() {
    print("init MobileTunePreviewCotroller");
    con = Get.put(MobileTunePreviewCotroller());

    playingIndex = widget.tuneList.indexOf(widget.tuneInfo);
    con.customInit(playingIndex, widget.tuneList);
    super.initState();
  }

  @override
  void dispose() {
    print("dispose MobileTunePreviewCotroller");
    Get.delete<MobileTunePreviewCotroller>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: white,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Obx(() {
                          return customImage(url: con.imageName.value);
                        }),
                        closeButton(context)
                      ],
                    )),
                Expanded(child: tuneInfoBuilder()),
                SizedBox(height: 150, child: bottomBuilder()),
                bottomButtons(),
              ],
            ),
          ),
        );
      },
    );
  }

  Column bottomBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        playerButtonbuilder(),
        Obx(() {
          return buyButton(con.currentTuneDetail.value,
              padding: const EdgeInsets.symmetric(horizontal: 30));
        }),
      ],
    );
  }

  Widget bottomButtons() {
    return Container(
      height: 70,
      color: lightGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          button(wishlistStr, wishlistPng),
          button(deleteStr, wishlistPng),
          button(shareStr, wishlistPng),
          button(giftStr, giftPng),
        ],
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GenericButton(
        padding: EdgeInsets.zero,
        leadingIcon: Icon(Icons.close),
        bgColor: lightGrey,
        height: 40,
        width: 40,
        onTap: () {
          Navigator.of(context).pop();
          //Get.back();
        },
      ),
    );
  }

  Widget playerButtonbuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Obx(
          () {
            return GenericButton(
              bgColor: white,
              height: 40,
              width: 40,
              borderColor: con.enablePreviousButton.value ? black : lightGrey,
              padding: EdgeInsets.zero,
              leadingIcon: Icon(
                Icons.skip_previous,
                color: con.enablePreviousButton.value ? yellow : lightGrey,
              ),
              onTap: () {
                con.previoustButtonTap(pCont);
              },
            );
          },
        ),
        GenericButton(
          bgColor: white,
          height: 65,
          width: 65,
          borderColor: black,
          padding: EdgeInsets.zero,
          leadingIcon: Obx(
            () {
              return Icon(
                pCont.playingToneId.value == con.currentTuneDetail.value.toneId
                    ? Icons.pause
                    : Icons.play_arrow_rounded,
                color: yellow,
              );
            },
          ),
          onTap: () {
            print("playing index is $playingIndex");
            con.isPlaying.value = !con.isPlaying.value;
            pCont.playUrl(con.currentTuneDetail.value);
          },
        ),
        Obx(
          () {
            return GenericButton(
              bgColor: white,
              height: 40,
              width: 40,
              borderColor: con.enableNextButton.value ? black : lightGrey,
              padding: EdgeInsets.zero,
              leadingIcon: Icon(
                Icons.skip_next,
                color: con.enableNextButton.value ? yellow : lightGrey,
              ),
              onTap: () {
                con.nextButtonTap(pCont);
              },
            );
          },
        )
      ],
    );
  }

  Widget tuneInfoBuilder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: con.tuneName.value,
                fontName: FontName.bold,
                fontSize: 18,
                textAlign: TextAlign.center,
              ),
              CustomText(
                title: con.artistName.value,
                textAlign: TextAlign.center,
                fontName: FontName.regular,
                color: grey,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget button(String title, String image) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 15,
          ),
          CustomText(title: title),
        ],
      ),
    );
  }
}
