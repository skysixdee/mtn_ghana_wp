import 'package:etisalat/files/controllers/my_wishlist_controller.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_empty_list_view.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWishlistScreen extends StatelessWidget {
  MyWishlistScreen({super.key});
  final MyWishlistController con = Get.find();
  List<PopoverMenuModel> popoverMenu = [PopoverMenuModel('Delete')];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoading.value
            ? loadingIndicator()
            : con.tuneList.isEmpty
                ? customEmptyListView()
                : GenericGridView(
                    itemCount: con.tuneList.length,
                    builder: (p0) {
                      return TuneCard(
                        isWishlist: true,
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
