import 'package:mtn_ghana_wp/files/controllers/banner_detail_controller.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class BannerDetailScreen extends StatelessWidget {
  BannerDetailScreen({super.key});
  final BannerDetailController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GenericScrollView(
          sliverToBoxAdapter: getNavigationView(bannersStr),
          isLoading: con.isLoading.value,
          itemCount: con.tuneList.length,
          builder: (p0) {
            return TuneCard(info: con.tuneList[p0], tuneList: con.tuneList);
          },
        );
      },
    );
  }
}
