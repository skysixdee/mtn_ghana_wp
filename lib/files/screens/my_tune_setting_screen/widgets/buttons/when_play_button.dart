import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_setting_screen/widgets/buttons/when_popover.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WhenPlayButton extends StatelessWidget {
  WhenPlayButton({super.key});
  final MyTuneSettingController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context1, constraints) {
        return ResponsiveBuilder(
          builder: (context, si) {
            return Obx(
              () {
                return InkWell(
                  onTap: () {
                    return;
                    whenPopover(context1, con);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: white,
                    ),
                    width: 200,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: con.timeTypeTitle.value,
                            fontName: FontName.bold,
                          ),
                          //const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
// Widget whenPlayButton() {
//   return
// }
