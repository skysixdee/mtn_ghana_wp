import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_grid_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_tab_view.dart';
import 'package:etisalat/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FeatureCategoryView extends StatefulWidget {
  const FeatureCategoryView({super.key});

  @override
  State<FeatureCategoryView> createState() => _FeatureCategoryViewState();
}

class _FeatureCategoryViewState extends State<FeatureCategoryView> {
  late FeatureController featureController;
  @override
  void initState() {
    featureController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return featureController.isLoading.value
            ? loadingIndicator(height: 300)
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: FeatureTabView()),
                  const SizedBox(height: 10),
                  FeatureGridView(),
                  const SizedBox(height: 10),
                  seeMoreButton()
                ],
              );
      },
    );
  }

  Row seeMoreButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GenericButton(
          textColor: red,
          title: seeMoreStr,
          bgColor: transparent,
          onTap: () {
            context.pushNamed(seeMoreRoute,
                extra: featureController.displayList);
            customPrint("See more tapped");
          },
        ),
      ],
    );
  }
}
