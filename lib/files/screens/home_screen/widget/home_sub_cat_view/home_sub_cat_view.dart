import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeSubCatView extends StatelessWidget {
  HomeSubCatView({super.key});
  AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
            color: isDarkTheme(context) ? blackTest : lightGreyTest,
            height: si.isMobile ? 100 : 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: appController.categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print("tapped");
                        String catId =
                            appController.categories[index].categoryId ?? '';

                        context.goNamed(categoryDetailRoute,
                            queryParameters: {'catId': catId});
                        //con.getCategoryDetailList(catId);
                      },
                      child: card(context, index, si),
                    );
                  },
                );
              }),
            ));
      },
    );
  }

  Padding card(BuildContext context, int index, SizingInformation si) {
    return Padding(
      padding: EdgeInsets.only(
          right: 14.0,
          left: index == 0 ? (si.isMobile ? 8 : 30) : 0,
          top: 4,
          bottom: 4), //const EdgeInsets.only(right: 12.0),
      child: Container(
        //height: 140,

        width: si.isMobile ? 140 : 220,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: isDarkTheme(context) ? blackD : white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: isDarkTheme(context) ? darkGrey : lightGrey,
                  blurRadius: 3,
                  spreadRadius: 1)
            ]),
        child: Stack(
          alignment: Alignment.center,
          children: [
            customImage(
              url: appController.categories[index].menuImage ?? "",
            ),
            // CustomText(
            //   title: appController.categories[index].categoryName,
            //   fontName: FontName.bold,
            //   color: white,
            // ),
          ],
        ),
      ),
    );
  }
}
