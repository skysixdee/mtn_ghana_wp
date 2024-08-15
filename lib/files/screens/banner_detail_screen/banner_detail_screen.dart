import 'package:etisalat/files/controllers/banner_detail_controller.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerDetailScreen extends StatelessWidget {
  BannerDetailScreen({super.key});
  final BannerDetailController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoading.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: con.tuneList.length,
                builder: (p0) {
                  return TuneCard(info: con.tuneList[p0]);
                },
              );
      },
    );
  }
}
