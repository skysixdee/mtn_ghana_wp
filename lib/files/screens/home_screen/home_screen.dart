import 'package:mtn_ghana_wp/files/api_calls/shuffle_enable_disable_api.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/web_footer_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_search_view/home_search_view.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/playing_tune_view/playing_tune_view_new.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/music_box_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_banner_view/home_banner_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/feature_view/feature_category_view.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/express_info_view/express_info_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MusicBoxController musicBoxController = Get.find();
  DateTime p0 = DateTime.now();
  @override
  void initState() {
    musicBoxController.getMusicBoxx();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return //MyTuneScreen();
        Material(
      color: white,
      child: customScroll(),
    );
  }

  Widget customScroll() {
    return CustomScrollView(
      primary: true,
      slivers: [
        SliverToBoxAdapter(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 8),
              HomeBannerView(key: widget.key),
              const SizedBox(height: 20),
              HomeSearchView(),
              const SizedBox(height: 20),
              const MusicBoxView(),
              const SizedBox(height: 30),
              FeatureCategoryView(key: widget.key),
              const SizedBox(height: 30),
              const ExpressInfoView(),
              const WebFooterView(),
            ],
          ),
        ),
      ],
    );
  }
}
