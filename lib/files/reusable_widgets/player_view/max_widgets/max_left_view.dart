import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_addtowishlist_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_next_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_play_pause_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_previous_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_share_button.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MaxLeftView extends StatelessWidget {
  MaxLeftView({super.key});
  final PlayerController playerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tuneImage(),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: white,
                    ),
                    width: 260,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        playerControls(),
                        const SizedBox(height: 6),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //   child: Divider(color: lightGrey, height: 1),
                        // ),
                        // shareSections(),
                        // SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Flexible(child: tuneInfo()),
          ],
        )
      ],
    );
  }

  Widget tuneInfo() {
    return SizedBox(
      child: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  title: playerController.info.value.toneName ?? '',
                  fontName: FontName.semiBold,
                  color: black,
                  fontSize: 25),
              CustomText(
                title: playerController.info.value.artistName ?? '',
                fontName: FontName.regular,
                //fontSize: 12,
                color: black,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  // GenericButton(
                  //   padding: EdgeInsets.symmetric(horizontal: 28),
                  //   height: 40,
                  //   radius: 20,
                  //   title: setCallerToneStr,
                  //   fontSize: 14,
                  //   fontName: FontName.medium,
                  //   bgColor: yellow,
                  //   onTap: () {
                  //     print("object");
                  //   },
                  // ),
                  playerController.isHideBuyButton.value
                      ? SizedBox()
                      : buyButton(playerController.info.value,
                          padding: const EdgeInsets.symmetric(horizontal: 20))
                ],
              ),
              const SizedBox(height: 20),
              CustomText(
                title: artistsStr,
                fontName: FontName.bold,
                fontSize: 18,
                color: black,
              ),
              const SizedBox(height: 8),
              // Row(
              //   children: [
              //     Flexible(
              //         child: CustomText(
              //       title: "Artist tone card",
              //     )
              //         // ArtistInfoCard(
              //         //   albumName: "Singer",
              //         //   artistName: 'Easy On Me Sunshine',
              //         //   index: 10,
              //         // ),
              //         ),
              //   ],
              // ),

              artistList()
            ],
          );
        },
      ),
    );
  }

  Widget artistList() {
    return Obx(
      () {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: playerController.artistList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 200,
              child: InkWell(
                  onTap: () async {
                    final PlayerController cont = Get.find();
                    cont.isPlayerMaxSize.value = false;
                    await Future.delayed(const Duration(milliseconds: 100));
                    print("navigating to artist page");
                    //if (Get.context != null) {
                    // context.goNamed(artistTuneRoute, queryParameters: {
                    //   'artistName': playerController.artistList[index]
                    // });
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: CustomText(
                      isSelectable: false,
                      maxLine: 1,
                      title: playerController.artistList[index],
                      fontName: FontName.regular,
                      color: black,
                      //fontSize: 12,
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  Widget tuneImage() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: lightGrey,
      ),
      width: 260,
      height: 270,
      child: Obx(
        () {
          return customImage(
              url: playerController.info.value.toneIdpreviewImageUrl);
        },
      ),
    );
  }

  Row shareSections() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buttonWithTitle(
          shareStr,
          shareIcon,
          action: () {
            print("object");
          },
        ),
        buttonWithTitle(playListStr, playlistIcon),
        buttonWithTitle(wishlistStr, likeIcon),
        buttonWithTitle(viewMoreStr, moreIcon),
      ],
    );
  }

  Row playerControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        playerShareButton(),
        playerPreviousButton(),
        playerPlayPauseButton(),
        playerNextbutton(),
        playerAddToWishListButton(),
      ],
    );
  }

  Widget buttonWithTitle(String title, String imag, {Function()? action}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GenericButton(
          height: 40,
          width: 40,
          radius: 20,
          padding: const EdgeInsets.all(0),
          onTap: action,
          title: "",
          leadingIcon: Image.asset(
            imag,
            height: 30,
          ),
        ),
        CustomText(
          title: title,
          fontSize: 10,
          fontName: FontName.regular,
          color: grey,
        )
      ],
    );
  }
}
