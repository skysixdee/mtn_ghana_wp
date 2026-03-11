import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

class HomeSubCatView extends StatelessWidget {
  HomeSubCatView({super.key});
  AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Obx(() {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: appController.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      customImage(
                          url: appController.categories[index].menuImage ?? "",
                          gredientColor: gredientColor),
                      CustomText(
                        title: appController.categories[index].categoryName,
                        fontName: FontName.bold,
                        color: white,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }));
  }
}
