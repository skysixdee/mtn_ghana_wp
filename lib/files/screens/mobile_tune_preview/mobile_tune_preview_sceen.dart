import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_from_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/delete_mytune_api.dart';
import 'package:mtn_ghana_wp/files/common/decode_html_text.dart';
import 'package:mtn_ghana_wp/files/controllers/mobile_tune_preview_cotroller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_wishlist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/custpm_screen_type.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/popup_views/gift_popup_view.dart';
import 'package:mtn_ghana_wp/files/popup_views/social_sharing_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileTunePreviewSceen extends StatefulWidget {
  const MobileTunePreviewSceen({
    super.key,
    required this.tuneInfo,
    required this.tuneList,
    required this.customScreenType,
  });
  final TuneInfo tuneInfo;
  final CustomScreenType customScreenType;
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
            child: mainColumn(context),
          ),
        );
      },
    );
  }

  Column mainColumn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Obx(() {
                  return customImage(
                      url: con.imageName.value, gredientColor: gredientColor);
                }),
                closeButton(context)
              ],
            )),
        Flexible(child: tuneInfoBuilder()),
        //tuneInfoBuilder(),
        SizedBox(height: 150, child: bottomBuilder()),
        bottomButtons(),
      ],
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
        children: widget.customScreenType == CustomScreenType.wishlist
            ? bottomButtonWishlistChildren
            : bottomButtonNonWishlistChildren,
      ),
    );
  }

  List<Widget> get bottomButtonWishlistChildren {
    return [
      button(
        deleteStr,
        widget: const Icon(
          Icons.delete,
          size: 18,
          color: red,
        ),
        onTap: () async {
          if (StoreManager.isLoggedIn) {
            if (widget.customScreenType == CustomScreenType.myTune) {
              con.deleteMyTune();
            } else {
              con.deleteTuneFromWishlist();
            }
          } else {
            openAlertPopup(message: thisFeatureIsAvailableForLoggedinStr);
          }
        },
      ),
      button(
        shareStr,
        widget: const Icon(
          Icons.share,
          size: 18,
          color: red,
        ),
        onTap: () {
          genericPopup(SocialSharingPopup(info: con.currentTuneDetail.value));
        },
      ),
      button(
        giftStr,
        image: giftPng,
        onTap: () {
          if (StoreManager.isLoggedIn) {
            genericPopup(GiftPopupView(info: con.currentTuneDetail.value));
          } else {
            openAlertPopup(message: thisFeatureIsAvailableForLoggedinStr);
          }
        },
      ),
    ];
  }

  List<Widget> get bottomButtonNonWishlistChildren {
    return [
      button(
        wishlistStr,
        image: wishlistPng,
        onTap: () {
          if (StoreManager.isLoggedIn) {
            addToWishlistApi(con.currentTuneDetail.value);
          } else {
            openAlertPopup(message: thisFeatureIsAvailableForLoggedinStr);
          }
        },
      ),
      button(
        shareStr,
        widget: const Icon(
          Icons.share,
          size: 18,
          color: red,
        ),
        onTap: () {
          genericPopup(SocialSharingPopup(info: con.currentTuneDetail.value));
        },
      ),
      button(
        giftStr,
        image: giftPng,
        onTap: () {
          if (StoreManager.isLoggedIn) {
            genericPopup(GiftPopupView(info: con.currentTuneDetail.value));
          } else {
            openAlertPopup(message: thisFeatureIsAvailableForLoggedinStr);
          }
        },
      ),
    ];
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
          height: 55,
          width: 55,
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
                title: decodeHtmlEntities(con.tuneName.value),
                fontName: FontName.bold,
                fontSize: 18,
                textAlign: TextAlign.center,
              ),
              CustomText(
                title: decodeHtmlEntities(con.artistName.value),
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

  Widget button(String title,
      {String? image, Widget? widget, Function()? onTap}) {
    return InkWell(
      onTap: () {
        (onTap != null) ? onTap() : print("object");
      },
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget ??
                Image.asset(
                  image ?? '',
                  height: 15,
                  color: red,
                ),
            CustomText(title: title),
          ],
        ),
      ),
    );
  }
}
