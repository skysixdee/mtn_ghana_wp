import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glossy/glossy.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_addtowishlist_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_next_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_play_pause_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_previous_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/buttons/player_share_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/max_widgets/max_right_view.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MaximizedMobileView extends StatefulWidget {
  MaximizedMobileView({super.key});

  @override
  State<MaximizedMobileView> createState() => _MaximizedMobileViewState();
}

class _MaximizedMobileViewState extends State<MaximizedMobileView> {
  final ScrollController _scrollController = ScrollController();

  PlayerController con = Get.find();
  @override
  void initState() {
    con.onMaxSize = () {
      _scrollController.animateTo(
        0, // Scroll to top position
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut, // Smooth scrolling effect
      );
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ListView(
            controller: _scrollController,
            shrinkWrap: true,
            children: [
              const SizedBox(height: 60),
              toneImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    playerControls(),
                    const SizedBox(height: 20),
                    CustomText(title: upNextStr, fontName: FontName.bold),
                    const SizedBox(height: 10),
                    tuneList(),
                    const SizedBox(height: 20),
                    CustomText(title: artistsStr, fontName: FontName.bold),
                    const SizedBox(height: 10),
                    artistList(),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
          closeButton()
        ],
      ),
    );
  }

  Widget closeButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GenericButton(
              padding: EdgeInsets.zero,
              width: 40,
              height: 40,
              bgColor: grey,
              leadingIcon: const Icon(Icons.fullscreen_exit, color: white),
              onTap: () {
                PlayerController con = Get.find();
                con.maximizePlayer(false);
                false;
              },
            ),
          ],
        ));
  }

  Widget toneImage() {
    return Obx(
      () {
        return SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Center(
                  child: customImage(
                      url: con.info.value.toneIdpreviewImageUrl,
                      fit: BoxFit.fitHeight)),
            ),
          ),
        );
      },
    );
  }

  Widget playerControls() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: lightGrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            playerShareButton(),
            playerPreviousButton(),
            playerPlayPauseButton(),
            playerNextbutton(),
            playerAddToWishListButton()
          ],
        ),
      ),
    );
  }

  Widget tuneList() {
    PlayerController con = Get.find();
    return Obx(
      () {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: con.list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4), color: lightGrey),
                  child: pleayerTuneCard(con, con.list[index], index)),
            );
          },
        );
      },
    );
  }

  Widget artistList() {
    return SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: con.artistList.length,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: yellow,
                  ),
                  child: artistCard(context, index),
                ),
              ),
            );
            // Column(
            //   children: [
            //     AspectRatio(
            //       aspectRatio: 1,
            //       child: Container(
            //         color: yellow,
            //         child: Padding(
            //           padding: const EdgeInsets.only(right: 8.0),
            //           child: Center(
            //             child: CustomText(
            //               title: con.artistList[index],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     CustomText(
            //       title: con.artistList[index],
            //     ),
            //   ],
            // );
          },
        ));
  }

  Widget artistCard(BuildContext ctx, int index) {
    return InkWell(
      onTap: () async {
        final PlayerController cont = Get.find();
        cont.isPlayerMaxSize.value = false;
        await Future.delayed(const Duration(milliseconds: 100));

        print(
            "move to artist tune view with artist name ${cont.artistList[index]}");
        ctx.goNamed(artistTuneRoute,
            queryParameters: {'artistName': con.info.value.artistName ?? ''});
        //if (Get.context != null) {
        // ctx.goNamed(artistTuneRoute,
        //     queryParameters: {'artistName': cont.artistList[index]});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: CustomText(
            isSelectable: false,
            fontName: FontName.semiBold,
            title: con.artistList[index],
            fontSize: 10,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
