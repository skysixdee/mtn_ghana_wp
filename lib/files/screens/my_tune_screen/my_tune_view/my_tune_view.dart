import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTuneView extends StatelessWidget {
  MyTuneView({super.key});
  final MyTuneController con = Get.find();
  List<PopoverMenuModel> menuList = [PopoverMenuModel(deleteStr)];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoading.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: con.tuneList.length,
                builder: (p0) {
                  return TuneCard(
                    info: con.tuneList[p0],
                    menuList: menuList,
                    bottomRightChild: settingButton(),
                    onMenuTap: (p0, p1) {
                      customPrint("title is = ${p0.title} and index = $p1");
                    },
                  );
                },
              );
      },
    );
  }

  Widget settingButton() {
    return GenericButton(
      title: settingStr,
      leadingIcon: Icon(
        Icons.settings,
        size: 15,
      ),
      onTap: () {
        customPrint("On Setting tap");
      },
    );
  }
}
