import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

import 'package:mtn_ghana_wp/files/common/number_pagination.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';

import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.searchKey, required this.index});
  final String searchKey;
  final String index;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TuneSearchController controller = Get.find();
  @override
  void initState() {
    if (widget.index == "2") {
      controller.getSongCodeSearch(widget.searchKey);
    } else if (widget.index == "1") {
      controller.getArtistSearch(widget.searchKey);
    } else {
      controller.getSongSearchResult(widget.searchKey);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: white,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  sliverNavigation(),
                  //sliverAppBar(),
                  SliverToBoxAdapter(child: grid()
                      // Obx(
                      //   () {
                      //     return controller.selectedIndex.value == 0
                      //         ?
                      //         : artistNameList();
                      //   },
                      // ),
                      ),
                ],
              ),
            ),
            _loadMore()
          ],
        ));
  }

  SliverToBoxAdapter sliverNavigation() {
    return SliverToBoxAdapter(
      child: getNavigationView(
          "$searchedResultForStr -> ${(widget.searchKey).toUpperCase()}"),
    );
  }

  SliverAppBar sliverAppBar() {
    return SliverAppBar(
      backgroundColor: yellow,
      pinned: true,
      toolbarHeight: 41,
      flexibleSpace: Column(
        children: [
          Container(height: 1, color: white),
        ],
      ),
    );
  }

  Widget _loadMore() {
    return Obx(
      () {
        return Stack(
          children: [
            numberPagination(
              totalCount: controller.totalTuneCount.value,
              onTap: (p0) => controller.leadMoreData(p0),
            ),
            Container(height: 40, color: white)
          ],
        );
      },
    );
  }

  Widget grid() {
    return Obx(
      () {
        return tuneGridView(
          isLoading:
              (controller.isLoading.value || controller.isLoadingMore.value),
          itemCount: controller.tuneList.length,
          onTap: (p0) {
            controller.leadMoreData(p0);
          },
          builder: (p0) {
            return TuneCard(
                info: controller.tuneList[p0], tuneList: controller.tuneList);
          },
        );
      },
    );
  }

  /*
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
                padding: EdgeInsets.zero,
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
                padding: EdgeInsets.zero,
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
  */
}
