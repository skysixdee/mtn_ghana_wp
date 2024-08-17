import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/controllers/name_tune_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/router/router.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MusicBoxView extends StatefulWidget {
  const MusicBoxView({super.key});

  @override
  State<MusicBoxView> createState() => _MusicBoxViewState();
}

class _MusicBoxViewState extends State<MusicBoxView> {
  final MusicBoxController con = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoadingList.value
            ? loadingIndicator()
            : SizedBox(
                height: 120,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: musicBoxStr,
                          fontName: FontName.bold,
                        ),
                        GenericButton(
                          title: seeMoreStr,
                          textColor: red,
                          bgColor: transparent,
                          onTap: () {
                            context.pushNamed(musicBoxRoute);
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: GenericGridView(
                        scrollDirection: Axis.horizontal,
                        itemCount: con.musicBoxList.length,
                        builder: (p0) {
                          return TuneCard(info: con.musicBoxList[p0]);
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
