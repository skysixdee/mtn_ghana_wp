import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_grid_view.dart';
import 'package:etisalat/files/screens/home_screen/widget/feature_view/feature_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  FeatureGridView()
                ],
              );
      },
    );
  }
}
