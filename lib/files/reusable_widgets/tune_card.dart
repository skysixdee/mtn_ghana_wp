import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/common/decode_html_text.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/enums/custpm_screen_type.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/popup_views/gift_popup_view.dart';
import 'package:mtn_ghana_wp/files/popup_views/social_sharing_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/play_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';

import 'package:mtn_ghana_wp/files/screens/mobile_tune_preview/mobile_tune_preview_sceen.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

import 'package:flutter/material.dart';

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
    required this.tuneList,
    this.customScreenType = CustomScreenType.normal,
  });

  final TuneInfo info;
  final CustomScreenType customScreenType;

  final List<TuneInfo> tuneList;
  final Widget? bottomLeftChild;
  final Widget? bottomRightChild;
  final Widget? bottomButtonChild;
  final Widget? moreButton;
  final List<PopoverMenuModel>? menuList;
  final Function(PopoverMenuModel, int)? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return laodWidget(si);
      },
    );
  }

  Widget laodWidget(SizingInformation si) {
    if (si.isMobile) {
      if (customScreenType == CustomScreenType.musicContent) {
        return mainContainer(si);
      } else {
        return InkWell(
          onTap: () {
            Get.dialog(
              Material(
                child: MobileTunePreviewSceen(
                    customScreenType: customScreenType,
                    tuneInfo: info,
                    tuneList: tuneList),
              ),
            );
          },
          child: mainContainer(si),
        );
      }
    } else {
      return mainContainer(si);
    }
  }

  Widget mainContainer(SizingInformation si) {
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
                child: moreButton ??
                    (si.isMobile
                        ? SizedBox()
                        : _moreButton(menuList, info, onMenuTap)),
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
                  title: decodeHtmlEntities(info.toneName ?? ''), //,
                  maxLine: 1,
                  fontName: FontName.bold,
                ),
                CustomText(
                  title: decodeHtmlEntities(
                      info.artistName ?? ''), //info.artistName ?? '',
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
                  if (StoreManager.isLoggedIn) {
                    addToWishlistApi(info);
                  } else {
                    openAlertPopup(
                        message: thisFeatureIsAvailableForLoggedinStr);
                  }
                } else if (p0.title == giftStr) {
                  if (StoreManager.isLoggedIn) {
                    Get.dialog(GiftPopupView(info: info));
                  } else {
                    openAlertPopup(
                        message: thisFeatureIsAvailableForLoggedinStr);
                  }

                  customPrint("gift tapped");
                } else {
                  customPrint("share tapped");
                  Get.dialog(SocialSharingPopup(info: info));
                }
              }
              if (onMenuTap != null) {
                await Future.delayed(const Duration(milliseconds: 300));
                onMenuTap(p0, index);
              }
            },
          );
        },
      );
    },
  );
}
