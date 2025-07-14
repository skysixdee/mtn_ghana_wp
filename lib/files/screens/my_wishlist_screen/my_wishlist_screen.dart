import 'package:mtn_ghana_wp/files/reusable_widgets/custom_screen_header_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/enums/custpm_screen_type.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/controllers/my_wishlist_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_empty_list_view.dart';

class MyWishlistScreen extends StatelessWidget {
  MyWishlistScreen({super.key});
  final MyWishlistController con = Get.find();
  List<PopoverMenuModel> popoverMenu = [PopoverMenuModel('Delete')];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GenericScrollView(
          sliverToBoxAdapter: CustomScreenHeaderView(
            imageName: myTuneHeaderPng,
            title: wishlistStr,
            subTitle: '',
          ),
          sliverAppBar: getNavigationView(wishlistStr),
          isLoading: con.isLoading.value,
          itemCount: con.tuneList.length,
          builder: (p0) {
            return TuneCard(
              customScreenType: CustomScreenType.wishlist,
              info: con.tuneList[p0],
              menuList: popoverMenu,
              tuneList: con.tuneList,
              onMenuTap: (p0, p1) {
                con.deleteFromWishlist(con.tuneList[p1]);
                customPrint("Title = ${p0.title} and index = $p1");
              },
            );
          },
        );
      },
    );
  }
}
