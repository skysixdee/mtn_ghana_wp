import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/common/decode_html_text.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_playing_tune_controller_new.dart';
import 'package:mtn_ghana_wp/files/controllers/player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/list_setting_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/play_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/playing_tune_view/widgets/playing_tune_card.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

class PlayingTuneViewNew extends StatefulWidget {
  const PlayingTuneViewNew({super.key});

  @override
  State<PlayingTuneViewNew> createState() => _PlayingTuneViewNewState();
}

class _PlayingTuneViewNewState extends State<PlayingTuneViewNew> {
  MyPlayingTuneControllerNew con = Get.find();
  PlayerController pCont = Get.find();
  @override
  void initState() {
    //con.getListSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoading.value ? loadingIndicator() : listView();
      },
    );
  }

  Widget listView() {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      shrinkWrap: true,
      itemCount: con.settingsList.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 0.9,
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      itemBuilder: (context, index) {
        final v = con.settingsList[index];
        return Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(8),
            color: white,
          ),
          child: Column(
            children: [
              Expanded(child: toneImage(v)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        CustomText(
                          title: decodeHtmlEntities(v.contentName ?? ''),
                          fontName: FontName.bold,
                        ),
                        CustomText(
                          title: decodeHtmlEntities(v.artistName ?? ''),
                          fontName: FontName.semiBold,
                          color: grey,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget toneImage(SettingsList info) {
    TuneInfo inf = TuneInfo(
      toneIdStreamingUrl: info.contentStreamingUrl ?? "",
      toneId: info.contentId,
      artistName: info.albumName,
      albumName: info.albumName,
      categoryId: '',
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        customImage(url: info.contentPreviewImageUrl),
        GenericButton(
          bgColor: white,
          borderColor: black,
          padding: EdgeInsets.all(0),
          width: 30,
          height: 30,
          leadingIcon: Icon(
            pCont.playingToneId.value == info.contentId
                ? Icons.pause
                : Icons.play_arrow_rounded,
            size: pCont.playingToneId.value == info.contentId ? 20 : 22,
            color: black,
          ),
          onTap: () {
            pCont.playUrl(inf);
          },
        ),
        //playButton(TuneInfo())
      ],
    );
  }
}
