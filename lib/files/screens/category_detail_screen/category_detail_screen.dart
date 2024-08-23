import 'package:etisalat/files/controllers/category_detail_controller.dart';
import 'package:etisalat/files/model/navigation_header_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailScreen extends StatelessWidget {
  CategoryDetailScreen({super.key, required this.name});
  final String name;
  final CategoryDetailController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoading.value
            ? loadingIndicator()
            : Column(
                children: [
                  NavigationHeaderView(titleList: [
                    NavigationHeaderModel(homeStr, homeRoute),
                    NavigationHeaderModel(name, nameTuneRoute),
                  ]),
                  Expanded(
                    child: GenericGridView(
                      itemCount: con.tuneList.length,
                      builder: (p0) {
                        return TuneCard(
                          info: con.tuneList[p0],
                          tuneList: con.tuneList,
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}
