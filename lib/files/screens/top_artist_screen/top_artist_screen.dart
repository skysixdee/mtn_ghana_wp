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
import 'package:responsive_builder/responsive_builder.dart';

class TopArtistScreen extends StatefulWidget {
  const TopArtistScreen({super.key});

  @override
  State<TopArtistScreen> createState() => _TopArtistScreenState();
}

class _TopArtistScreenState extends State<TopArtistScreen> {
  List<ArtistList> artistList = [];
  RxBool isLoading = false.obs;
  RxInt totalCount = 0.obs;
  int? currentPage;
  RxString selectedTab = 'ALL'.obs;
  getArtist({String? selectedTab, int page = 0}) async {
    isLoading.value = true;
    totalCount.value = 0;
    ArtistsModel model =
        await getArtistListApi(selectedTab ?? "", pageNo: page);
    var ls = model.responseMap?.artistList ?? [];
    artistList.assignAll(ls);
    totalCount.value = model.responseMap?.resultCount ?? 0;
    isLoading.value = false;
  }

  List<String> tabList = [
    "ALL",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  @override
  void initState() {
    // TODO: implement initState
    getArtist(selectedTab: "");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Center(
          child: Obx(
            () {
              return Column(
                children: [
                  //artistSearchTabView(),
                  Expanded(
                    child: GenericScrollView(
                      sliverToBoxAdapter:
                          getNavigationView(artistStr), //sliverNavigation(),
                      isLoading: isLoading.value,
                      extraWidgetToolBarHeight: 40,
                      extraWidegt: artistSearchTabView(si),
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
                                  color: isDarkTheme(context)
                                      ? darkGrey
                                      : lightGrey,
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
                                      child:
                                          customImage(toneName: inf.val ?? '')),
                                ),
                              ),
                              CustomText(
                                fontName: FontName.semiBold,
                                title: inf.val ?? '',
                                fontSize: 12,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12),
                                child: GenericButton(
                                  title: viewStr,
                                  bgColor:
                                      isDarkTheme(context) ? yellowD : yellow,
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
                    Obx(
                      () {
                        return numberPagination(
                            currentPage: currentPage,
                            totalCount: totalCount.value,
                            onTap: (v) {
                              currentPage = (v ~/ pagePerCount);
                              print("===========${v}");
                              getArtist(
                                  selectedTab: selectedTab.value == "ALL"
                                      ? ""
                                      : selectedTab.value,
                                  page: v);
                            });
                      },
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget artistSearchTabView(SizingInformation si) {
    return SizedBox(
        //color: white,
        //height: 40,
        child: ListView.builder(
      padding: EdgeInsets.only(left: si.isMobile ? 12 : 30),
      scrollDirection: Axis.horizontal,
      itemCount: tabList.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Obx(
                  () {
                    return GenericButton(
                      fontName: si.isMobile ? FontName.semiBold : FontName.bold,
                      fontSize: si.isMobile ? 12 : 14,
                      borderColor: grey,
                      bgColor: selectedTab.value == tabList[index]
                          ? isDarkTheme(context)
                              ? yellowD
                              : yellow
                          : isDarkTheme(context)
                              ? whiteD
                              : white,
                      height: 20,
                      title: tabList[index],
                      onTap: () {
                        currentPage = 0;
                        selectedTab.value = tabList[index];
                        getArtist(
                            selectedTab: selectedTab.value == "ALL"
                                ? ""
                                : selectedTab.value);
                        print("object");
                      },
                    );
                  },
                ))
            // CustomText(
            //   title: tabList[index],
            // ),
            );
      },
    ));
  }

  onSearchAction(String key) {
    ArtistsTuneController cont1 = Get.find();
    cont1.isLoading.value = false;
    context.goNamed(artistTuneRoute, queryParameters: {'artistName': key});
  }
}
