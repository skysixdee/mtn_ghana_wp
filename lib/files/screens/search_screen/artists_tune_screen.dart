import 'package:etisalat/files/common/number_pagination.dart';
import 'package:etisalat/files/controllers/artists_tune_controller.dart';
import 'package:etisalat/files/model/navigation_header_model.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistsTuneScreen extends StatefulWidget {
  const ArtistsTuneScreen({super.key, required this.artistName});
  final String artistName;
  @override
  State<ArtistsTuneScreen> createState() => _ArtistsTuneScreenState();
}

class _ArtistsTuneScreenState extends State<ArtistsTuneScreen> {
  ArtistsTuneController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return GenericScrollView(
                  isLoading: con.isLoading.value,
                  sliverAppBar: NavigationHeaderView(titleList: [
                    NavigationHeaderModel(homeStr, homeRoute),
                    NavigationHeaderModel(searchStr, searchRoute),
                    NavigationHeaderModel(widget.artistName, homeRoute)
                  ]),
                  itemCount: con.tuneList.length,
                  builder: (p0) {
                    return TuneCard(
                        info: con.tuneList[p0], tuneList: con.tuneList);
                  },
                );
              },
            ),
          ),
          pagination(),
        ],
      ),
    );
  }

  Widget pagination() {
    return Obx(
      () {
        return numberPagination(
          totalCount: con.totalToneCount.value,
          onTap: (p0) => con.loadMoreData(p0),
        );
      },
    );
  }
}
