import 'package:mtn_ghana_wp/files/controllers/banner_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/banner_detail_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

class HomeBannerView extends StatelessWidget {
  HomeBannerView({super.key});
  final BannerController cont = Get.find();

  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return cont.isLoading.value
                ? loadingIndicator(height: 200)
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        color: isDarkTheme(context) ? blackD : white,
                        child: widgetList(si, context),
                      ),
                      indicatorView(),
                    ],
                  );
          },
        );
      },
    );
  }

  CarouselSlider widgetList(SizingInformation si, BuildContext context) {
    BannerDetailController bannerDetailController = Get.find();
    return CarouselSlider(
      controller: carouselSliderController,
      items: cont.banners.map((banner) {
        //cont.banners.map((banner) {
        return InkWell(
          onTap: () {
            bannerDetailController.getBannerDetail(
                banner.type ?? '', banner.searchKey ?? '');
            context.goNamed(bannerDetailRoute, queryParameters: {
              'type': banner.type,
              'searchKey': banner.searchKey
            });
            //carouselSliderController.animateToPage(i);
          },
          child: Container(
              decoration: const BoxDecoration(color: transparent),
              child: customImage(
                  cornerRadius: 8,
                  url: banner.bannerPath,
                  gredientColor:
                      isDarkTheme(context) ? gredientColor : transparent)),
        );
      }).toList(),
      options: carousalOption(si, context),
    );
  }

  CarouselOptions carousalOption(SizingInformation si, BuildContext context) {
    return CarouselOptions(
      height: si.isMobile ? 160 : (MediaQuery.of(context).size.width * 0.17),
      aspectRatio: 16 / 9,
      viewportFraction: si.isMobile ? 0.9 : 0.333,
      initialPage: cont.selectedIndex.value,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      onPageChanged: (index, reason) {
        cont.updatedSelectedIndex(index);
      },
      scrollDirection: Axis.horizontal,
    );
  }

  Widget indicatorView() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cont.banners.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  cont.selectedIndex.value = index;
                  carouselSliderController.animateToPage(index);
                  customPrint("tapped $index");
                },
                child: Obx(
                  () {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: white, width: 1.5),
                        borderRadius: BorderRadius.circular(6),
                        color: cont.selectedIndex.value == index ? red : grey,
                      ),
                      height: 12,
                      width: 12,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
