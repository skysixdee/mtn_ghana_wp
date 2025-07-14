import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_textfield.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class HomeSearchView extends StatelessWidget {
  HomeSearchView({super.key});

  final TuneSearchController con = Get.find();

  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 40.0, bottom: 20, right: 20),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                CustomTextfield(
                  addSearchIcon: true,
                  hintColor: grey,
                  bgColor: white,
                  hintText: typeToSearchStr,
                  controller: textEditingController,
                  borderColor: white,
                  onChange: (p0) {
                    con.searchedText = p0;
                    customPrint("On change $p0");
                  },
                  onSubmit: (p0) {
                    con.searchedText = p0;

                    onSearchAction(p0, context); //goNamed(searchRoute);
                    customPrint("on submit $p0");
                  },
                ),
                searchTypeBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSearchAction(String p0, BuildContext context) {
    con.isLoading.value = false;
    if (con.searchTypeIndex.value == 2) {
      con.getSongCodeSearch(p0);
      context.goNamed(searchRoute, queryParameters: {
        'search': p0,
        'index': "${con.searchTypeIndex.value}"
      }); //goNamed(searchRoute);
    } else if (con.searchTypeIndex.value == 1) {
      con.getArtistSearch(p0);
      context.goNamed(artistsRoute, queryParameters: {
        'search': p0,
        'index': "${con.searchTypeIndex.value}"
      }); //goNamed(searchRoute);
    } else {
      con.getSongSearchResult(p0);
      context.goNamed(searchRoute, queryParameters: {
        'search': p0,
        'index': "${con.searchTypeIndex.value}"
      }); //goNamed(searchRoute);
    }
  }

  Widget searchTypeBuilder() {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        songSearchBuilder(),
        artistSearchBuilder(),
        codeSearchBuilder()
      ],
    );
  }

  GenericButton songSearchBuilder() {
    return GenericButton(
      title: tunesStr,
      fontName: FontName.regular,
      leadingIcon: Obx(
        () {
          return Icon(
              con.searchTypeIndex.value == 0
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18);
        },
      ),
      onTap: () {
        con.searchTypeIndex.value = 0;
        customPrint("Song Search");
      },
    );
  }

  GenericButton artistSearchBuilder() {
    return GenericButton(
      title: artistStr,
      fontName: FontName.regular,
      leadingIcon: Obx(
        () {
          return Icon(
              con.searchTypeIndex.value == 1
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18);
        },
      ),
      onTap: () {
        con.searchTypeIndex.value = 1;
        customPrint("Song Search");
      },
    );
  }

  Widget codeSearchBuilder() {
    return Obx(
      () {
        return GenericButton(
          title: codeStr,
          fontName: FontName.regular,
          leadingIcon: Icon(
            con.searchTypeIndex.value == 2
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            size: 18,
          ),
          onTap: () {
            con.searchTypeIndex.value = 2;
            customPrint("code Search");
          },
        );
      },
    );
  }
}
