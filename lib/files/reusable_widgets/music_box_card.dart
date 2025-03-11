import 'package:mtn_ghana_wp/files/enums/fonts.dart';
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
  final TuneInfo info;
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
              'type': info.type,
              'code': info.toneId,
              'toneName': info.toneName,
              'toneId': info.toneId,
              'imgUrl': info.toneIdpreviewImageUrl,
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
                          //imageName: 'assets/pngs/music_box_$index.png',
                          url: info.toneIdpreviewImageUrl,
                          toneName: info.previewImageUrl ?? ''))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: info.toneName ?? '',
                      fontName: FontName.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leftButton ??
                            GenericButton(
                              padding: EdgeInsets.zero,
                              bgColor: transparent,
                              title: previewStr,
                              leadingIcon: const Icon(Icons.visibility),
                              onTap: () {
                                context.goNamed(
                                    isMyMusicBox
                                        ? myMusicBoxContentRoute
                                        : musicBoxContentRoute,
                                    queryParameters: {
                                      'type': info.type,
                                      'code': info.toneId,
                                      'toneName': info.toneName,
                                      'toneId': info.toneId,
                                      'imgUrl': info.toneIdpreviewImageUrl,
                                    });
                                print("view all tune in music box");
                              },
                            ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: SizedBox(
                            //width: 80,
                            child: rightButton ??
                                buyButton(info,
                                    isMusicBox: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0)),
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
