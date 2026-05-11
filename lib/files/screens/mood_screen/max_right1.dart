import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/category_detail_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MaxRightView2 extends StatelessWidget {
  final String expression;
  MaxRightView2({super.key, required this.expression});

  final RxInt selectedIndex = 0.obs;
  final CategoryDetailController categoryController =
      Get.put(CategoryDetailController());

  @override
  Widget build(BuildContext context) {
    categoryController.getCategoryDetailList1("happy", "123");

   // categoryController.getCategoryDetailList1("happy", "123");

    final PlayerController cont = Get.find();

    return Stack(
      children: [
        Column(
          children: [
            toggle(),
            const SizedBox(height: 8),
            Flexible(child: listView(context)),
            const SizedBox(height: 80),
          ],
        ),
      ],
    );
  }

  Widget toggle() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: upNextButton()),
          ],
        ),
        const SizedBox(height: 1),
        SizedBox(
          height: 4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(color: Colors.grey, height: 1),
              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: selectedIndex.value == 0
                            ? Colors.yellow
                            : Colors.white,
                        height: 4,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        )
      ],
    );
  }

  Widget upNextButton() {
    return Obx(() {
      return InkWell(
        onTap: () => selectedIndex.value = 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$expression Tunes',
            style: TextStyle(
                fontWeight: selectedIndex.value == 0
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: 16,
                color: appCont.isDarkTheme.value ? white : yellow),
          ),
        ),
      );
    });
  }

  Widget listView(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (categoryController.tuneList.isEmpty) {
        return Center(
            child: Text(
          "No tunes available",
          style: TextStyle(color: appCont.isDarkTheme.value ? white : yellow),
        ));
      }

      // return ListView.builder(
      //   padding: const EdgeInsets.only(right: 12),
      //   itemCount: categoryController.tuneList.length,
      //   shrinkWrap: true,
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 6.0),
      //       child: playerTuneCard(
      //         context,
      //         categoryController.tuneList[index],
      //         index,
      //       ),
      //     );
      //   },
      // );
      return ListView.builder(
        padding: const EdgeInsets.only(right: 12),
        itemCount: categoryController.tuneList.length,
        shrinkWrap: false, // 👈 CHANGE to false
        physics: const AlwaysScrollableScrollPhysics(), // 👈 ADD
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: playerTuneCard(
              context,
              categoryController.tuneList[index],
              index,
            ),
          );
        },
      );
    });
  }

  Widget playerTuneCard(BuildContext context, TuneInfo info, int index) {
    final PlayerController cont = Get.find();

    return InkWell(
      onTap: () {
        cont.info.value = info;
        cont.isPlayerVisible.value = true;
      },
      child: ResponsiveBuilder(
        builder: (context, si) {
          return SizedBox(
            height: 50,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(si.isMobile ? 4.0 : 0),
                    child: customImage(
                      cornerRadius: 4,
                      url: info.toneIdpreviewImageUrl ?? "",
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: info.toneName ?? "Unknown",
                        color: appCont.isDarkTheme.value ? whiteD : yellow,
                        fontName: FontName.bold,
                      ),
                      Flexible(
                        child: CustomText(
                          title: info.artistName ?? "Unknown Artist",
                          color: appCont.isDarkTheme.value ? whiteD : yellow,
                          fontName: FontName.regular,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
