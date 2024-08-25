import 'package:etisalat/files/common/number_pagination.dart';
import 'package:etisalat/files/controllers/tune_search_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/navigation_header_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/router/router.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.searchKey});
  final String searchKey;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TuneSearchController controller = Get.find();
  @override
  void initState() {
    controller.getResult(widget.searchKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return controller.isLoading.value
                    ? loadingIndicator()
                    : Column(
                        children: [
                          NavigationHeaderView(titleList: [
                            NavigationHeaderModel(homeStr, homeRoute),
                            NavigationHeaderModel(
                                "$searchedResultForStr -> ${(widget.searchKey).toUpperCase()}",
                                homeRoute)
                          ]),
                          Container(height: 1, color: white),
                          topTab(),
                          Expanded(
                            child: controller.selectedIndex.value == 0
                                ? grid()
                                : artistNameList(),
                          ),
                        ],
                      );
              },
            ),
          ),
          Obx(
            () {
              return Stack(
                children: [
                  numberPagination(),
                  controller.selectedIndex.value == 0
                      ? const SizedBox()
                      : Container(
                          height: 40,
                          color: white,
                        )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget numberPagination() {
    return Obx(
      () {
        return Visibility(
          visible: (controller.totalTuneCount.value > pagePerCount),
          child: NumberPagination(
            totalItem: controller.totalTuneCount.value,
            tappedIndex: (value) {
              controller.leadMoreData(value);
              print("tapped index");
            },
          ),
        );
      },
    );
  }

  Widget grid() {
    return Obx(
      () {
        return controller.isLoadingMore.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: controller.tuneList.length,
                builder: (p0) {
                  return TuneCard(
                      info: controller.tuneList[p0],
                      tuneList: controller.tuneList);
                },
              );
      },
    );
  }

  Widget artistNameList() {
    return ListView.builder(
      itemCount: controller.artistList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String artistName = controller.artistList[index].matchedParam ?? '';
        String title = '';
        if (artistName.isNotEmpty) {
          List<String> ls = artistName.split(" ");
          for (var i = 0; i < ls.length; i++) {
            if (i < 2) {
              title += ls[i][0];
            }
          }
        }
        return InkWell(
            onTap: () {
              context.goNamed(artistTuneRoute, queryParameters: {
                'artistName': controller.artistList[index].matchedParam ?? ''
              });
              print("artist tapped");
            },
            child: artistCardBuilder(title, index));
      },
    );
  }

  Padding artistCardBuilder(String title, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: yellow,
                  ),
                  height: 40,
                  width: 40,
                  child: Center(
                    child: CustomText(
                      title: title,
                      fontSize: 16,
                      fontName: FontName.bold,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 10,
                  color: transparent,
                ),
                CustomText(
                  title: controller.artistList[index].matchedParam,
                  fontSize: 16,
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
              color: grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget topTab() {
    return SizedBox(
      height: 40,
      child: Obx(
        () {
          return Row(
            children: [
              Expanded(
                  child: GenericButton(
                radius: 0,
                title: tunesStr,
                bgColor:
                    controller.selectedIndex.value == 0 ? yellow : lightGrey,
                onTap: () {
                  controller.selectedIndex.value = 0;
                },
              )),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                  child: GenericButton(
                radius: 0,
                title: artistStr,
                bgColor:
                    controller.selectedIndex.value == 1 ? yellow : lightGrey,
                onTap: () {
                  controller.selectedIndex.value = 1;
                },
              )),
            ],
          );
        },
      ),
    );
  }
}
