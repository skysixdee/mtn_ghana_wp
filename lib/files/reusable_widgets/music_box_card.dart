import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/buy_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MusicBoxCard extends StatelessWidget {
  const MusicBoxCard({super.key, required this.info, this.rightButton});
  final TuneInfo info;
  final Widget? rightButton;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(musicBoxContentRoute,
            queryParameters: {'type': info.type, 'code': info.toneId});
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: 220,
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
                      color: yellow,
                      child: customImage(
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
                        GenericButton(
                          padding: EdgeInsets.zero,
                          bgColor: transparent,
                          title: previewStr,
                          leadingIcon: const Icon(Icons.visibility),
                        ),
                        rightButton ?? buyButton(info)
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
