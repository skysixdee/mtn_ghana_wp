import 'package:mtn_ghana_wp/files/reusable_widgets/web_footer_view.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/home_controllers/home_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_search_view/home_search_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_sub_cat_view/home_sub_cat_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/new_feature_view/new_feature_view.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/playing_tune_view/playing_tune_view_new.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/music_box_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/feature_view/feature_category_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/express_info_view/express_info_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MusicBoxController musicBoxController = Get.find();
  final HomeController homeController = Get.find<HomeController>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _categoryKey = GlobalKey();
  DateTime p0 = DateTime.now();
  
  @override
  void initState() {
    musicBoxController.getMusicBoxx();
    homeController.attachScrollController(_scrollController, _categoryKey);
    super.initState();
  }

  @override
  void dispose() {
    homeController.detachScrollController(_scrollController);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return //MyTuneScreen();
        Material(
      color: isDarkTheme(context) ? blackD : white,
      child: customScroll(),
    );
  }

  Widget customScroll() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return CustomScrollView(
          controller: _scrollController,
          primary: false,
          slivers: [
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 8),
                  HomeBannerView(key: widget.key),
                  //SizedBox(height: si.isMobile ? 10 : 20),
                  SizedBox(height: si.isMobile ? 20 : 40),
                  HomeSearchView(),
                  //SizedBox(height: si.isMobile ? 10 : 20),
                  SizedBox(height: si.isMobile ? 20 : 40),
                  HomeSubCatView(key: _categoryKey),
                  // SizedBox(height: si.isMobile ? 20 : 40),
                  // const MusicBoxView(),
                  SizedBox(height: si.isMobile ? 20 : 50),
                  //FeatureCategoryView(key: widget.key),
                  NewFeatureView(),
                  SizedBox(height: si.isMobile ? 20 : 30),
                  const ExpressInfoView(),
                  const WebFooterView(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
