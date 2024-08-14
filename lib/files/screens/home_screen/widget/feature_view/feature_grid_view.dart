import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FeatureGridView extends StatelessWidget {
  FeatureGridView({super.key});
  final FeatureController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return cont.isLoadingList[cont.index.value]
            ? loadingIndicator(height: 300)
            : GridView.builder(
                shrinkWrap: true,
                itemCount: cont.displayList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Container(
                    color: yellow,
                    child: CustomText(
                        title: cont.displayList[index].toneName ?? ''),
                  );
                },
              );
      },
    );
  }
}
