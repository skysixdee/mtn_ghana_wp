import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/name_tune_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/music_box_card.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicBoxView extends StatefulWidget {
  const MusicBoxView({super.key});

  @override
  State<MusicBoxView> createState() => _MusicBoxViewState();
}

class _MusicBoxViewState extends State<MusicBoxView> {
  final MusicBoxController con = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          //color: isDarkTheme(context) ? whiteD : lightGrey,
          child: Obx(
            () {
              return con.isLoadingList.value
                  ? loadingIndicator()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: si.isMobile ? 8.0 : 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title: musicBoxStr,
                                fontName: FontName.bold,
                                fontSize: si.isMobile ? 16 : 20,
                              ),
                              GenericButton(
                                textColor:
                                    isDarkTheme(context) ? whiteD : black,
                                title: seeMoreStr,
                                textColorD: whiteD,
                                bgColor: Colors.transparent,
                                borderColor: grey,
                                fontSize: si.isMobile ? 12 : 14,
                                onTap: () {
                                  context.push(musicBoxRoute);
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: si.isMobile ? 200 : 280,
                              child: ListView.builder(
                                itemCount: con.musicBoxList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: index == 0 ? 6.0 : 0,
                                        right: 16.0,
                                        top: 6),
                                    child: MusicBoxCard(
                                      width: si.isMobile ? 160 : null,
                                      info: con.musicBoxList[index],
                                      index: index,
                                    ),
                                  );
                                },
                              )),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
