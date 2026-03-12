import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/about_page_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/about_page_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late AboutPageController controller;
  @override
  void initState() {
    //con = Get.put(AboutPageController());
    Get.lazyPut(() => AboutPageController());
    controller = Get.find();
    print("init ====_AboutScreenState");
    super.initState();
  }

  @override
  void dispose() {
    print("dispose ====_AboutScreenState");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.getPageDeatil();

    return Scaffold(
      //appBar: AppBar(title: const Text("About Page")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.aboutList.isEmpty) {
          return const Center(child: Text("No data found"));
        }

        return ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 40),
            aboutTopSection(),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: controller.aboutList.length,
              itemBuilder: (context, sectionIndex) {
                final section = controller.aboutList[sectionIndex];

                return Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    headerText(section, sectionIndex),
                    if (sectionIndex == 1) advancedSetting(),
                    const SizedBox(height: 10),
                    //horizintalList(section),
                    colrousal(section, sectionIndex),
                    if (sectionIndex == 0) startDiscovering(context),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget aboutTopSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    isSelectable: true,
                    textAlign: TextAlign.center,
                    title: aboutTitleStr,
                    fontName: FontName.extraBold,
                    fontSize: 30,
                    color: black,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    isSelectable: true,
                    textAlign: TextAlign.center,
                    title: aboutSunTitleStr,
                    fontName: FontName.semiBold,
                    color: greyDark,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Image.asset(
              aboutMainPng,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ],
    );
  }

  Widget colrousal(AboutList section, int sectionIndex) {
    return CarouselSlider(
        items: List.generate(section.dataList?.length ?? 0, (v) {
          String svgs = section.dataList?[v].data?.first.iconName ?? '';
          return corousalCard(svgs, section, v, sectionIndex);
        }),
        options: CarouselOptions(
          height: 280,
          aspectRatio: sectionIndex == 2 ? 16 / 1 : 16 / 9,

          viewportFraction: sectionIndex == 2 ? 0.2 : 0.3,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: sectionIndex == 2 ? 0.0 : 0.3,
          //onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ));
  }

  Column corousalCard(String svgs, AboutList section, int v, int sectionIndex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        SvgPicture.asset(
          height: 60,
          width: 60,
          'assets/svgs/$svgs.svg',
          colorFilter: isDarkTheme(context)
              ? ColorFilter.mode(
                  whiteD, sectionIndex == 1 ? BlendMode.dst : BlendMode.srcIn)
              : const ColorFilter.mode(
                  Color.fromARGB(255, 17, 98, 237),
                  BlendMode.dst,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomText(
            isSelectable: true,
            title: section.dataList?[v].data?.first.iconTitle,
            fontName: FontName.extraBold,
            fontSize: 18,
          ),
        ),
        Flexible(
          child: CustomText(
            isSelectable: true,
            title: section.dataList?[v].data?.first.text,
            fontName: FontName.semiBold,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget startDiscovering(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GenericButton(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            title: startDiscoveringStr,
            textColor: black,
            bgColor: isDarkTheme(context) ? yellowD : yellow,
            onTap: () {
              context.goNamed(homeRoute);
              print("tapped");
            },
          ),
        ],
      ),
    );
  }

  Row advancedSetting() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/svgs/about_settings.svg',
        ),
        CustomText(
          isSelectable: true,
          title: advancedSettingStr,
          fontName: FontName.extraBold,
          fontSize: 22,
        )
      ],
    );
  }

  Padding headerText(AboutList section, int sectionIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: CustomText(
        title: section.header ?? '',
        color: sectionIndex == 0 ? greyDark : black,
        fontName: FontName.extraBold,
        fontSize: 24,
      ),
    );
  }
}
