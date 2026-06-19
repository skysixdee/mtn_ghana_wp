import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/common/decode_html_text.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/enums/custpm_screen_type.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/popup_views/gift_popup_view.dart';
import 'package:mtn_ghana_wp/files/popup_views/social_sharing_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/open_login.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/mp_play_button.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class TuneCard extends StatelessWidget {
  const TuneCard({
    super.key,
    required this.info,
    this.bottomLeftChild,
    this.bottomRightChild,
    this.bottomButtonChild,
    this.moreButton,
    this.menuList,
    this.onMenuTap,
    required this.tuneList,
    this.isMoreAlwaysVisible = false,
    this.customScreenType = CustomScreenType.normal,
  });

  final TuneInfo info;
  final CustomScreenType customScreenType;
  final bool isMoreAlwaysVisible;
  final List<TuneInfo> tuneList;
  final Widget? bottomLeftChild;
  final Widget? bottomRightChild;
  final Widget? bottomButtonChild;
  final Widget? moreButton;
  final List<PopoverMenuModel>? menuList;
  final Function(PopoverMenuModel, int)? onMenuTap;

  @override
  Widget build(BuildContext context) {
    // Single global sizing context for this item instance
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile && customScreenType != CustomScreenType.musicContent) {
      return InkWell(
        onTap: () {
          // Navigation preview action placeholder
        },
        child: _buildMainContainer(context, isMobile),
      );
    }
    return _buildMainContainer(context, isMobile);
    // ResponsiveBuilder(
    //   builder: (context, si) {

    //   },
    // );
  }

  Widget _buildMainContainer(BuildContext context, bool isMobile) {
    final bool dark = isDarkTheme(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: dark ? blackD : white,
        boxShadow: [
          BoxShadow(
            color: dark ? darkGrey : lightGrey,
            blurRadius: 3,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                customImage(
                  url: info.toneIdpreviewImageUrl,
                  fit: BoxFit.fill,
                  gredientColor: dark ? gredientColor : transparent,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: moreButton ??
                      ((!isMobile || isMoreAlwaysVisible)
                          ? _MoreButtonWidget(
                              info: info,
                              menuList: menuList,
                              onMenuTap: onMenuTap,
                            )
                          : const SizedBox.shrink()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: decodeHtmlEntities(info.toneName ?? ''),
                  maxLine: 1,
                  fontName: FontName.bold,
                ),
                CustomText(
                  title: decodeHtmlEntities(info.artistName ?? ''),
                  color: black,
                  fontName: FontName.semiBoldItalic,
                  fontSize: 12,
                  maxLine: 1,
                ),
                const SizedBox(height: 4),
                bottomButtonChild ??
                    Row(
                      children: [
                        Expanded(
                          child: bottomLeftChild ??
                              MpPlayButton(tuneList: tuneList, tuneInfo: info),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: bottomRightChild ?? buyButton(info),
                        ),
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

// Extracted into a standalone specialized component to keep tree metrics decoupled
class _MoreButtonWidget extends StatelessWidget {
  final TuneInfo info;
  final List<PopoverMenuModel>? menuList;
  final Function(PopoverMenuModel, int)? onMenuTap;

  const _MoreButtonWidget({
    required this.info,
    this.menuList,
    this.onMenuTap,
  });

  void _handleAuthRequiredAction(VoidCallback onSuccess) {
    if (StoreManager.isLoggedIn) {
      onSuccess();
    } else {
      openAlertPopup(
        message: thisFeatureIsAvailableForLoggedinStr,
        textAlign: TextAlign.center,
        primaryBtnTitle: cancelStr,
        secondryBtnTitle: loginStr,
        secondryTitleColor: black,
        onSecondry: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          openLogin();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericButton(
      borderColor: black,
      bgColor: isDarkTheme(context) ? whiteD : white,
      width: 30,
      height: 30,
      padding: EdgeInsets.zero,
      leadingIcon: const Icon(
        Icons.more_horiz_outlined,
        size: 18,
      ),
      onTap: () {
        // Fallback default list instantiated locally only inside click scope runtime
        final List<PopoverMenuModel> items = menuList ??
            [
              PopoverMenuModel(wishlistStr),
              PopoverMenuModel(giftStr),
              PopoverMenuModel(shareStr),
            ];

        genericPopover(
          context,
          items,
          onTap: (p0, index) async {
            customPrint("tapped ${p0.title} and index =$index");

            if (menuList == null) {
              if (p0.title == wishlistStr) {
                _handleAuthRequiredAction(() => addToWishlistApi(info));
              } else if (p0.title == giftStr) {
                _handleAuthRequiredAction(
                    () => genericPopup(GiftPopupView(info: info)));
              } else if (p0.title == shareStr) {
                genericPopup(SocialSharingPopup(info: info));
              }
            }

            if (onMenuTap != null) {
              await Future.delayed(const Duration(milliseconds: 300));
              onMenuTap!(p0, index);
            }
          },
        );
      },
    );
  }
}
