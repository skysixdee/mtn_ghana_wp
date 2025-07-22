import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/music_box_sc_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MusicBoxCard extends StatelessWidget {
  const MusicBoxCard(
      {super.key,
      required this.info,
      this.rightButton,
      this.leftButton,
      this.isMyMusicBox = false,
      required this.index});
  final int index;
  final MusicBoxList info;
  final Widget? rightButton;
  final Widget? leftButton;
  final bool isMyMusicBox;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(
            isMyMusicBox ? myMusicBoxContentRoute : musicBoxContentRoute,
            queryParameters: {
              'id': info.musicBoxId,
              'boxName': info.musicBoxName,
              'boxImage': info.musicBoxIdpreviewImageUrl
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: 240,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: white,
              boxShadow: const [
                BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      color: lightGrey,
                      child: customImage(
                          imageName: 'assets/pngs/music_box_$index.png',
                          url: info.musicBoxIdpreviewImageUrl))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: info.musicBoxName ?? '',
                      fontName: FontName.bold,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 36,
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              print(
                                  "info.musicBoxName == ${info.musicBoxName}");
                              context.goNamed(
                                isMyMusicBox
                                    ? myMusicBoxContentRoute
                                    : musicBoxContentRoute,
                                queryParameters: {
                                  'id': info.musicBoxId,
                                  'boxName': info.musicBoxName,
                                  'boxImage': info.musicBoxIdpreviewImageUrl
                                },
                              );
                              print("view all tune in music box");
                            },
                            child: leftButton ??
                                OutlinedButton.icon(
                                  onPressed: null,
                                  icon: const Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: black,
                                  ),
                                  label: CustomText(
                                    title: previewStr,
                                    //fontName: FontName.bold,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    side: const BorderSide(color: black),
                                    foregroundColor: black,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: SizedBox(
                            height: 36,
                            //width: 80,
                            child: rightButton ??
                                // GenericButton(
                                //   title: "Buy",
                                //   onTap: () {
                                //     print("implemnt buy music box here ");
                                //   },
                                // )
                                buyButton(
                                    TuneInfo(
                                        toneId: info.musicBoxId,
                                        toneName: info.musicBoxName,
                                        toneIdpreviewImageUrl:
                                            info.musicBoxIdpreviewImageUrl,
                                        previewImageUrl:
                                            info.musicBoxIdpreviewImageUrl),
                                    isMusicBox: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
