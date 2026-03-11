import 'package:mtn_ghana_wp/files/controllers/home_controllers/feature_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/feature_view/feature_grid_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/feature_view/feature_tab_view.dart';
import 'package:mtn_ghana_wp/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: isDarkTheme(context) ? blackD : white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 25),
            child: Obx(
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
                          Flexible(child: FeatureGridView()),
                          const SizedBox(height: 10),
                          seeMoreButton()
                        ],
                      );
              },
            ),
          ),
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
          textColor: black,
          title: seeMoreStr,
          bgColor: Colors.transparent,
          borderColor: grey,
          onTap: () {
            context.pushNamed(seeMoreRoute,
                queryParameters: {
                  'name': featureController
                      .tabList[featureController.index.value].name
                },
                extra: featureController.displayList);

            customPrint("See more tapped");
          },
        ),
      ],
    );
  }
}
