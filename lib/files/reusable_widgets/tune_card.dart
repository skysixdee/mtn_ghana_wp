import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/buy_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/play_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_popover.dart';
import 'package:etisalat/files/utility/colors.dart';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TuneCard extends StatelessWidget {
  TuneCard({
    super.key,
    required this.info,
    this.bottomLeftChild,
    this.bottomRightChild,
    this.moreButton,
    this.menuList,
    this.onMenuTap,
  });

  final TuneInfo info;
  final Widget? bottomLeftChild;
  final Widget? bottomRightChild;
  final Widget? moreButton;
  final List<PopoverMenuModel>? menuList;
  final Function(PopoverMenuModel, int)? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: white,
          boxShadow: const [
            BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Expanded(
              child: Stack(
            alignment: Alignment.topRight,
            children: [
              customImage(url: info.toneIdpreviewImageUrl),
              Padding(
                padding: const EdgeInsets.all(8),
                child: moreButton ?? _moreButton(menuList, onMenuTap),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: info.toneName ?? '',
                  maxLine: 1,
                  fontName: FontName.bold,
                ),
                CustomText(
                  title: info.artistName ?? '',
                  color: grey,
                  fontName: FontName.semiBoldItalic,
                  fontSize: 12,
                  maxLine: 1,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: bottomLeftChild ?? playButton(info)),
                    const SizedBox(width: 12),
                    Expanded(child: bottomRightChild ?? buyButton(info)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_moreButton(List<PopoverMenuModel>? menuList,
    Function(PopoverMenuModel, int)? onMenuTap) {
  return ResponsiveBuilder(
    builder: (context, si) {
      return GenericButton(
        width: 30,
        height: 30,
        padding: EdgeInsets.zero,
        leadingIcon: const Icon(
          Icons.more_horiz_outlined,
          size: 18,
        ),
        onTap: () {
          genericPopover(
            context,
            menuList ??
                [
                  PopoverMenuModel("Wishlist"),
                  PopoverMenuModel("Gift"),
                  PopoverMenuModel("Share"),
                ],
            onTap: (p0, index) {
              print("tapped ${p0.title} and index =$index");
              if (menuList == null) {
                print("menuList is null");
              }
              if (onMenuTap != null) {
                onMenuTap(p0, index);
              }
            },
          );
        },
      );
    },
  );
}
