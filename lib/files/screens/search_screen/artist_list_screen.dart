import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/common/number_pagination.dart';
import 'package:mtn_ghana_wp/files/controllers/artists_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';

import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

import 'package:mtn_ghana_wp/files/utility/strings.dart';

class ArtistListScreen extends StatefulWidget {
  ArtistListScreen({super.key, required this.searchKey, required this.index});
  final String searchKey;
  final String index;

  @override
  State<ArtistListScreen> createState() => _ArtistListScreenState();
}

class _ArtistListScreenState extends State<ArtistListScreen> {
  final TuneSearchController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getArtistSearch(widget.searchKey);
  }

  final TuneSearchController con = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme(context) ? blackTest : white,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                sliverNavigation(),
                SliverToBoxAdapter(child: grid(context)),
              ],
            ),
          ),
          _loadMore()
        ],
      ),
    );
  }

  SliverToBoxAdapter sliverNavigation() {
    return SliverToBoxAdapter(
      child: getNavigationView(widget.searchKey.isEmpty
          ? ("$artistsResultForStr ${(widget.searchKey).toUpperCase()}")
          : ("$artistsResultForStr -> ${(widget.searchKey).toUpperCase()}")),
    );
  }

  Widget grid(BuildContext context) {
    return Obx(
      () {
        return tuneGridView(
          physics: NeverScrollableScrollPhysics(),
          cardWidth: 130,
          aspectRatio: 0.8,
          isLoading:
              (controller.isLoading.value || controller.isLoadingMore.value),
          itemCount: controller.artistsList.length,
          onTap: (p0) {
            final inf = controller.artistsList[p0];
            onSearchAction(inf.val ?? '');
            print("tapped ${inf.val}");
          },
          builder: (p0) {
            final inf = controller.artistsList[p0];
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: isDarkTheme(context) ? darkGrey : lightGrey,
                      blurRadius: 3,
                      spreadRadius: 1)
                ],
                borderRadius: BorderRadius.circular(4),
                color: isDarkTheme(context) ? blackTest : white,
              ),
              child: Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          width: double.infinity,
                          height: double.maxFinite,
                          child: customImage(toneName: inf.val ?? '')),
                    ),
                  ),
                  CustomText(
                    fontName: FontName.bold,
                    title: inf.val ?? '',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: GenericButton(
                      title: viewStr,
                      bgColor: isDarkTheme(context) ? yellowD : yellow,
                      onTap: () {
                        onSearchAction(inf.val ?? '');
                        print("tapped");
                      },
                    ),
                  )
                ],
              ),
            );

            // TuneCard(
            //     info: controller.tuneList[p0], tuneList: controller.tuneList);
          },
        );
      },
    );
  }

  onSearchAction(String key) {
    ArtistsTuneController cont1 = Get.find();
    cont1.isLoading.value = false;
    context.goNamed(artistTuneRoute, queryParameters: {'artistName': key});
  }

  Widget _loadMore() {
    return Stack(
      children: [
        //Container(height: 40, color: red),
        Obx(
          () {
            return numberPagination(
              totalCount: controller.totalTuneCount.value,
              onTap: (p0) => controller.leadMoreData(p0),
            );
          },
        ),
      ],
    );
    // Obx(
    //   () {
    //     return
    //   },
    // );
  }
}
