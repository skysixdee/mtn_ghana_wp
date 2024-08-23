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
  @override
  void initState() {
    playingIndex = widget.tuneList.indexOf(widget.tuneInfo);
    super.initState();
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
                        customImage(url: widget.tuneInfo.toneIdpreviewImageUrl),
                        closeButton(context)
                      ],
                    )),
                Expanded(
                    child: SizedBox(
                  child: tuneInfoBuilder(),
                )),
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
        buyButton(widget.tuneInfo,
            padding: const EdgeInsets.symmetric(horizontal: 30)),
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
        GenericButton(
          bgColor: white,
          height: 40,
          width: 40,
          borderColor: grey,
          padding: EdgeInsets.zero,
          leadingIcon: Icon(Icons.skip_previous),
        ),
        GenericButton(
          bgColor: white,
          height: 40,
          width: 40,
          borderColor: grey,
          padding: EdgeInsets.zero,
          leadingIcon: Icon(Icons.play_arrow_rounded),
          onTap: () {
            print("playing index is $playingIndex");
          },
        ),
        GenericButton(
          bgColor: white,
          height: 40,
          width: 40,
          borderColor: grey,
          padding: EdgeInsets.zero,
          leadingIcon: Icon(Icons.skip_next),
        )
      ],
    );
  }

  Widget tuneInfoBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          title: widget.tuneInfo.toneName ?? '',
          fontName: FontName.bold,
          fontSize: 18,
          textAlign: TextAlign.center,
        ),
        CustomText(
          title: widget.tuneInfo.artistName ?? '',
          textAlign: TextAlign.center,
          fontName: FontName.regular,
          color: grey,
        ),
      ],
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
