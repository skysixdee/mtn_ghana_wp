import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/artists_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/predictive_search_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/empty_list_widget.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ConsolidatedSearchScreen extends StatefulWidget {
  ConsolidatedSearchScreen({super.key});

  @override
  State<ConsolidatedSearchScreen> createState() =>
      _ConsolidatedSearchScreenState();
}

class _ConsolidatedSearchScreenState extends State<ConsolidatedSearchScreen> {
  PredictiveSearchController cont = Get.find();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return //songListViewBuilder();
        Scaffold(body: ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          children: [
            tabView(context),
            Expanded(
              child: Obx(
                () {
                  return cont.selectedIndex.value == 0
                      ? songListViewBuilder()
                      : (cont.selectedIndex.value == 1
                          ? artistListViewBuilder(context, si)
                          : songCodeListViewBuilder());
                },
              ),
            )
          ],
        );
      },
    ));
  }

  Widget tabView(BuildContext context) {
    Color selectedColor = isDarkTheme(context) ? yellowD : yellow;
    Color unSelectedColor = isDarkTheme(context) ? whiteD : lightGrey;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              Expanded(
                child: GenericButton(
                  radius: 2,
                  bgColor: cont.selectedIndex.value == 0
                      ? selectedColor
                      : unSelectedColor,
                  title: songsStr,
                  onTap: () {
                    cont.selectedIndex.value = 0;
                  },
                ),
              ),
              Expanded(
                child: GenericButton(
                  radius: 2,
                  bgColor: cont.selectedIndex.value == 1
                      ? selectedColor
                      : unSelectedColor,
                  title: artistsStr,
                  onTap: () {
                    cont.selectedIndex.value = 1;
                  },
                ),
              ),
              Expanded(
                child: GenericButton(
                  radius: 2,
                  bgColor: cont.selectedIndex.value == 2
                      ? selectedColor
                      : unSelectedColor,
                  title: codeStr,
                  onTap: () {
                    cont.selectedIndex.value = 2;
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget songListViewBuilder() {
    return Obx(
      () {
        return cont.isLoadingSongList.value
            ? loadingIndicator()
            : cont.songList.isEmpty
                ? emptyListWidget()
                : GenericScrollView(
                    builder: (p0) {
                      return TuneCard(
                          info: cont.songList[p0], tuneList: cont.songList);
                    },
                    itemCount: cont.songList.length);
      },
    );
  }

  Widget songCodeListViewBuilder() {
    return Obx(
      () {
        return cont.isLoadingCode.value
            ? loadingIndicator()
            : cont.codeList.isEmpty
                ? emptyListWidget()
                : GenericScrollView(
                    builder: (p0) {
                      return TuneCard(
                          info: cont.codeList[p0], tuneList: cont.codeList);
                    },
                    itemCount: cont.codeList.length);
      },
    );
  }

  Widget artistListViewBuilder(BuildContext context, SizingInformation si) {
    return Obx(
      () {
        return cont.isLoadingArtistList.value
            ? loadingIndicator()
            : GenericScrollView(
                cardWidth: 140,
                builder: (p0) {
                  return InkWell(
                    onTap: () {
                      ArtistsTuneController cont1 = Get.find();
                      cont1.isLoading.value = false;
                      context.goNamed(artistTuneRoute, queryParameters: {
                        'artistName': cont.artistList[p0].val ?? ''
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isDarkTheme(context) ? blackD : white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    isDarkTheme(context) ? darkGrey : lightGrey,
                                blurRadius: 3,
                                spreadRadius: 1)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: lightGrey,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: CustomText(
                                    isSelectable: false,
                                    fontName: FontName.bold,
                                    fontSize: si.isMobile ? 18 : 25,
                                    title: getInitials(
                                        cont.artistList[p0].val ?? ''),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomText(
                              isSelectable: false,
                              maxLine: 3,
                              textAlign: TextAlign.center,
                              fontName: FontName.bold,
                              fontSize: si.isMobile ? 12 : 16,
                              title: cont.artistList[p0].val,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: cont.artistList.length);
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: cont.artistList.length,
        //     itemBuilder: (context, index) {
        //       return Text("data");
        //     });
      },
    );
  }

  String getInitials(String name) {
    List<String> nameParts = name.trim().split(' ');

    if (nameParts.isEmpty) return '';

    if (nameParts.length == 1) {
      // Single name - take first 2 chars
      return nameParts[0].length >= 2
          ? nameParts[0].substring(0, 2).toUpperCase()
          : nameParts[0].toUpperCase();
    }

    // Multiple names - take first char of first and last name
    String firstInitial = nameParts.first[0];
    String lastInitial = nameParts.last[0];
    return (firstInitial + lastInitial).toUpperCase();
  }
}
