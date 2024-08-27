import 'package:etisalat/files/common/number_pagination.dart';
import 'package:etisalat/files/controllers/category_detail_controller.dart';
import 'package:etisalat/files/model/navigation_header_model.dart';

import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/get_navigation_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';

import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';

class CategoryDetailScreen extends StatelessWidget {
  CategoryDetailScreen({super.key, required this.name});
  final String name;
  final CategoryDetailController con = Get.find();
  NumberPaginatorController numberPaginatorController =
      NumberPaginatorController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return con.isLoading.value
                    ? loadingIndicator()
                    : GenericScrollView(
                        collapsedHeight: 56,
                        sliverAppBar: getNavigationView(name),
                        // NavigationHeaderView(titleList: [
                        //   NavigationHeaderModel(homeStr, homeRoute),
                        //   NavigationHeaderModel(name, nameTuneRoute),
                        // ]),
                        itemCount: con.tuneList.length,
                        builder: (p0) {
                          return TuneCard(
                            info: con.tuneList[p0],
                            tuneList: con.tuneList,
                          );
                        },
                      );
              },
            ),
          ),
          Obx(
            () {
              return numberPagination(
                totalCount: con.totalTuneCount.value,
                onTap: (p0) => con.loadMoreData(p0),
              );
            },
          )
        ],
      ),
    );
  }
}
