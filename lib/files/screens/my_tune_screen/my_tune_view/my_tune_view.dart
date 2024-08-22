import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/music_box_card.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTuneView extends StatelessWidget {
  MyTuneView({super.key});
  final MyTuneController con = Get.find();
  List<PopoverMenuModel> menuList = [PopoverMenuModel(deleteStr)];
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return con.isLoading.value
                ? loadingIndicator()
                : GenericGridView(
                    cardWidth: 250,
                    itemCount: con.tuneList.length,
                    builder: (p0) {
                      return TuneCard(
                        info: con.tuneList[p0],
                        menuList: menuList,
                        bottomRightChild: settingButton(context, si, p0),
                        onMenuTap: (p0, p1) {
                          if (p0.title == deleteStr) {
                            con.deleteTune(con.tuneList[p1]);
                          }
                          customPrint("title is = ${p0.title} and index = $p1");
                        },
                      );
                    },
                  );
          },
        );
      },
    );
  }

  Widget settingButton(BuildContext contex, SizingInformation si, int index) {
    return GenericButton(
      fontName: si.isMobile ? FontName.regular : FontName.bold,
      padding: EdgeInsets.zero,
      title: settingStr,
      bgColor: yellow,
      leadingIcon: const Icon(
        Icons.settings,
        size: 15,
      ),
      onTap: () {
        MyTuneSettingController settingCon = Get.find();
        settingCon.resetValue();
        contex.goNamed(myTunesSettingRoute, extra: con.tuneList[index]);
        customPrint("On Setting tap");
      },
    );
  }
}
