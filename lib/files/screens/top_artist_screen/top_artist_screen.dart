import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/api_calls/artists_search_api.dart';
import 'package:mtn_ghana_wp/files/common/number_pagination.dart';
import 'package:mtn_ghana_wp/files/controllers/artists_tune_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/artists_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class TopArtistScreen extends StatefulWidget {
  const TopArtistScreen({super.key});

  @override
  State<TopArtistScreen> createState() => _TopArtistScreenState();
}

class _TopArtistScreenState extends State<TopArtistScreen> {
  List<ArtistList> artistList = [];
  RxBool isLoading = false.obs;
  int totalCount = 0;
  getArtist({int page = 0}) async {
    isLoading.value = true;

    ArtistsModel model = await getArtistListApi("", pageNo: page);
    artistList = model.responseMap?.artistList ?? [];
    totalCount = model.responseMap?.resultCount ?? 0;
    isLoading.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getArtist();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () {
          return Column(
            children: [
              Expanded(
                child: GenericScrollView(
                  sliverAppBar:
                      getNavigationView(artistStr), //sliverNavigation(),
                  isLoading: isLoading.value,
                  cardWidth: 100,
                  onlyGrid: true,
                  childAspectRatio: 1.3,
                  itemCount: artistList.length,
                  builder: (p0) {
                    ArtistList inf = artistList[p0];
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color:
                                  isDarkTheme(context) ? darkGrey : lightGrey,
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
                  },
                ),
              ),
              if (totalCount > pagePerCount)
                numberPagination(
                    totalCount: totalCount,
                    onTap: (v) {
                      getArtist(page: v);
                    })
            ],
          );
        },
      ),
    );
  }

  onSearchAction(String key) {
    ArtistsTuneController cont1 = Get.find();
    cont1.isLoading.value = false;
    context.goNamed(artistTuneRoute, queryParameters: {'artistName': key});
  }
}
