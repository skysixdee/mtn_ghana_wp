import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/home_controllers/new_feature_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

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
      //color: isDarkTheme(context) ? whiteD : lightGrey,
      child: titleListView(),
    );
    // Obx(() {
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: lightGrey,
    //         //color: isDarkTheme(context) ? blackD : white,
    //         borderRadius: BorderRadius.circular(12),
    //         border: Border.all(color: greyDark, width: 1),
    //       ),
    //       child: titleListView(),
    //     ),
    //   );
    // });
  }

  ListView titleListView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cont.categories.length,
      itemBuilder: (context, index) {
        final category = cont.categories[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomText(
                title: category.title,
                fontName: FontName.bold,
                fontSize: 20,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 260,
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
  }

  ListView tuneList(TuneCategory category) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: category.tunes.length,
      itemBuilder: (context, tuneIndex) {
        final tune = category.tunes[tuneIndex];

        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AspectRatio(
              aspectRatio: 0.75,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TuneCard(info: tune, tuneList: category.tunes),
              )
              // Container(
              //   decoration: BoxDecoration(
              //     color: white,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: CustomText(
              //       title: tune.toneName ?? '',
              //       fontName: FontName.semiBold,
              //       fontSize: 14),
              // ),
              ),
        );
      },
    );
  }
}
