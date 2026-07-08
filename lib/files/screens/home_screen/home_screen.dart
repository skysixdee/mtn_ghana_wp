import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/api_calls/shuffle_enable_disable_api.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/predictive_search/predictive_search.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/web_footer_view.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/home_controllers/home_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_pop_banner_view/home_pop_banner_view.dart';
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
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/main.dart';
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
  final GlobalKey searchKey = GlobalKey();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    musicBoxController.getMusicBoxx();
    homeController.attachScrollController(_scrollController, _categoryKey);
    searchFocusNode.addListener(_handleFocusChange);
    super.initState();
  }

  void _handleFocusChange() {
    if (searchFocusNode.hasFocus) {
      // Small post-frame delay ensures the layout coordinates are stable if a keyboard is resizing the viewport
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSearch());
    }
  }

  void _scrollToSearch() {
    if (searchKey.currentContext != null) {
      Scrollable.ensureVisible(
        searchKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0, // Moves it seamlessly right to the top edge
      );
    }
  }

  @override
  void dispose() {
    // FIX: Clean up focus nodes to prevent unexpected memory leaks
    homeController.detachScrollController(_scrollController);
    searchFocusNode.removeListener(_handleFocusChange);
    searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return //MyTuneScreen();
        Material(
      color: isDarkTheme(context) ? blackD : white,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return ListView(
            shrinkWrap: true,
            children: [
              Obx(
                () {
                  return SizedBox(
                      height: appCont.isShowHomePopBanner.value ? 80 : 8);
                },
              ),
              HomeBannerView(key: widget.key),
              SizedBox(height: si.isMobile ? 20 : 40),
              PredictiveSearch(
                key: searchKey,
                focusNode: searchFocusNode,
              ),
              SizedBox(height: si.isMobile ? 20 : 40),
              HomeSubCatView(key: _categoryKey),
              SizedBox(height: si.isMobile ? 20 : 50),
              const NewFeatureView(),
              SizedBox(height: si.isMobile ? 20 : 30),
              const ExpressInfoView(),
              const WebFooterView(),
            ],
          );
        },
      ),
    );
  }
}
