import 'package:etisalat/files/api_calls/add_to_wishlist_api.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/popup_views/gift_popup_view.dart';
import 'package:etisalat/files/reusable_widgets/buttons/buy_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/play_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_popover.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TuneCard extends StatelessWidget {
  TuneCard({
    super.key,
    required this.info,
    this.bottomLeftChild,
    this.bottomRightChild,
    this.bottomButtonChild,
    this.moreButton,
    this.menuList,
    this.onMenuTap,
  });

  final TuneInfo info;
  final Widget? bottomLeftChild;
  final Widget? bottomRightChild;
  final Widget? bottomButtonChild;
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
                child: moreButton ?? _moreButton(menuList, info, onMenuTap),
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
                (bottomButtonChild == null)
                    ? Row(
                        children: [
                          Expanded(child: bottomLeftChild ?? playButton(info)),
                          const SizedBox(width: 12),
                          Expanded(child: bottomRightChild ?? buyButton(info)),
                        ],
                      )
                    : bottomButtonChild!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_moreButton(List<PopoverMenuModel>? menuList, TuneInfo info,
    Function(PopoverMenuModel, int)? onMenuTap) {
  return ResponsiveBuilder(
    builder: (context, si) {
      return GenericButton(
        borderColor: black,
        bgColor: white,
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
                  PopoverMenuModel(wishlistStr),
                  PopoverMenuModel(giftStr),
                  PopoverMenuModel(shareStr),
                ],
            onTap: (p0, index) async {
              customPrint("tapped ${p0.title} and index =$index");
              if (menuList == null) {
                customPrint("menuList is null");
                if (p0.title == wishlistStr) {
                  addToWishlistApi(info);
                } else if (p0.title == giftStr) {
                  await Future.delayed(const Duration(milliseconds: 200));
                  Get.dialog(GiftPopupView(info: info));
                  customPrint("gift tapped");
                } else {
                  customPrint("share tapped");
                }
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
