import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/home_controllers/new_feature_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/empty_list_widget.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NewFeatureView extends StatefulWidget {
  const NewFeatureView({super.key});

  @override
  State<NewFeatureView> createState() => _NewFeatureViewState();
}

class _NewFeatureViewState extends State<NewFeatureView> {
  late NewFeatureController cont;

  @override
  void initState() {
    super.initState();
    cont = Get.put(NewFeatureController());
  }

  @override
  void dispose() {
    Get.delete<NewFeatureController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkTheme(context) ? blackTest : lightGreyTest,
      child: titleListView(),
    );
  }

  Widget titleListView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return ListView.builder(
              padding:
                  EdgeInsets.symmetric(horizontal: si.isMobile ? 10 : 30.0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cont.categories.length,
              itemBuilder: (context, index) {
                final category = cont.categories[index];

                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: si.isMobile ? 8 : 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: 10),
                      CustomText(
                        title: category.title,
                        fontName: FontName.bold,
                        fontSize: 20,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: si.isMobile ? 220 : 260,
                        child: Obx(() {
                          if (category.isLoading.value) {
                            return loadingIndicator();
                          }

                          return tuneList(category);
                        }),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget tuneList(TuneCategory category) {
    return category.tunes.isEmpty
        ? emptyListWidget()
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 8.0, top: 4),
            scrollDirection: Axis.horizontal,
            itemCount: category.tunes.length,
            itemBuilder: (context, tuneIndex) {
              final tune = category.tunes[tuneIndex];

              return Padding(
                padding: EdgeInsets.only(
                  left: tuneIndex == 0 ? 4 : 0,
                  right: 16,
                ), //const EdgeInsets.only(right: 20.0),
                child: AspectRatio(
                    aspectRatio: 0.75,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TuneCard(info: tune, tuneList: category.tunes),
                    )),
              );
            },
          );
  }
}
