import 'package:etisalat/files/common/number_pagination.dart';
import 'package:etisalat/files/controllers/name_tune_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/navigation_header_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_screen_header_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/custom_textfield.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';

import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NameTuneScreen extends StatelessWidget {
  NameTuneScreen({super.key});
  final NameTuneController con = Get.find();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          Expanded(child: Obx(
            () {
              return GenericScrollView(
                sliverToBoxAdapter: CustomScreenHeaderView(
                  imageName: nameTuneHeaderPng,
                  title: nameTuneStr,
                  subTitle: nameTuneSubtitleOvalStr,
                ),
                collapsedHeight: 131,
                isLoading: con.isLoading.value,
                sliverAppBar: Column(
                  children: [
                    searchNameTuneBuilder(),
                    Container(height: 1, color: white),
                    NavigationHeaderView(titleList: [
                      NavigationHeaderModel(homeStr, homeRoute),
                      NavigationHeaderModel(nameTuneStr, nameTuneRoute),
                    ]),
                  ],
                ),
                itemCount: con.tuneList.length,
                builder: (p0) {
                  return TuneCard(
                    info: con.tuneList[p0],
                    moreButton: const SizedBox(),
                    tuneList: con.tuneList,
                  );
                },
              );
            },
          )),
          Obx(
            () {
              return numberPagination(
                  totalCount: con.totalToneCount.value,
                  onTap: (p0) {
                    con.isSearch
                        ? con.loadMoreSearchedData(p0)
                        : con.loadMoreData(p0);
                  });
            },
          ),
        ],
      ),
    );
  }

  Widget searchNameTuneBuilder() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          height: si.isMobile ? 110 : 80,
          color: lightGrey,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 1,
                left: si.isMobile ? 8 : 25,
                right: si.isMobile ? 8 : 25),
            child: si.isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(),
                      const SizedBox(height: 2),
                      textField(si),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title(),
                      Flexible(child: textField(si)),
                    ],
                  ),
          ),
        );
      },
    );
  }

  SizedBox textField(SizingInformation si) {
    return SizedBox(
      width: si.isMobile ? null : 300,
      child: CustomTextfield(
        hintText: enterNameStr,
        hintColor: grey,
        addSearchIcon: true,
        controller: textEditingController,
        borderColor: transparent,
        bgColor: white,
        onSubmit: (p0) {
          con.searchNameTune(p0);
        },
      ),
    );
  }

  CustomText title() {
    return CustomText(
      title: nameTuneStr,
      fontName: FontName.bold,
      fontSize: 16,
    );
  }
}
