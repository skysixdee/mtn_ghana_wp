import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

whenPopover(
  BuildContext context,
  MyTuneSettingController con,
) {
  List<PopoverMenuModel> menuList = [
    PopoverMenuModel(fullDayStr),
    // PopoverMenuModel(selectTimeStr),
    // PopoverMenuModel(selectDateAndTimeStr)
  ];
  genericPopover(
    context,
    menuList,
    width: 200,
    onTap: (p0, p1) {
      con.updateTimeType(p1);
      print("====== $p0 ==== $p1");
    },
  );
}
