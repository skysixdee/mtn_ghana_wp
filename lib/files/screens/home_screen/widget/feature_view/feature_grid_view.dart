import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/generic_popover.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';

class FeatureGridView extends StatelessWidget {
  FeatureGridView({super.key});
  final FeatureController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return cont.isLoadingList[cont.index.value]
            ? loadingIndicator(height: 300)
            : GenericGridView(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    cont.displayList.length > 8 ? 7 : cont.displayList.length,
                onTap: (p0) {
                  customPrint(
                      "tapped cell = ${cont.displayList[p0].toneName ?? ''}");
                },
                builder: (p0) {
                  return TuneCard(
                    info: cont.displayList[p0],
                  );
                },
              );
      },
    );
  }
}
