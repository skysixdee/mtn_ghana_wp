import 'package:etisalat/files/controllers/blacklist_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/blackList_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/custom_screen_header_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/get_navigation_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BlacklistScreen extends StatelessWidget {
  BlacklistScreen({super.key});
  final BlacklistController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: ResponsiveBuilder(
          builder: (context, si) {
            return Obx(
              () {
                return GenericScrollView(
                  isLoading: con.isLoading.value,
                  collapsedHeight: 150,
                  sliverToBoxAdapter: CustomScreenHeaderView(),
                  sliverAppBar: Column(
                    children: [
                      headerView(context, si),
                      getNavigationView(blackListStr),
                    ],
                  ),
                  childAspectRatio: 0.9,
                  cardWidth: 200,
                  itemCount: con.list.length,
                  builder: (p0) {
                    return blackListCard(con.list[p0], si);
                  },
                );
              },
            );
          },
        ));
  }

  Widget headerView(BuildContext context, SizingInformation si) {
    return Container(
      color: white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 28.0, horizontal: si.isMobile ? 8 : 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: howToCreateBlacklistStr,
                      fontName: FontName.regular,
                      color: grey,
                    ),
                    const SizedBox(width: 8),
                    learnMoreButton(),
                  ],
                ),
              ],
            ),
            GenericButton(
              title: createBlacklistStr,
              bgColor: yellow,
              onTap: () {
                context.goNamed(createBlackListRoute);
              },
            ),
          ],
        ),
      ),
    );
  }

  GenericButton learnMoreButton() {
    return GenericButton(
      height: 20,
      padding: EdgeInsets.zero,
      title: learnMoreStr,
      trailingIcon: const Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 10,
          color: yellow,
        ),
      ),
      fontName: FontName.regular,
      bgColor: transparent,
      textColor: yellow,
      onTap: () {
        openAlertPopup(message: blacklistLearnMoreStr);
      },
    );
  }

  Widget blackListCard(BPartyDetailsList info, SizingInformation si) {
    List<String> ls = (info.bPartyName ?? '').split(" ");
    String title = '';
    for (var i = 0; i < ls.length; i++) {
      if (i < 2) {
        title += ls[i][0];
      }
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
        ],
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            nameInitial(title),
            nameAndNumber(info),
            deleteButton(info, si)
          ],
        ),
      ),
    );
  }

  Container nameInitial(String title) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: yellow,
      ),
      child: Center(
        child: CustomText(
          title: title.toUpperCase(),
          fontName: FontName.bold,
        ),
      ),
    );
  }

  Widget deleteButton(BPartyDetailsList info, SizingInformation si) {
    return Obx(
      () {
        return GenericButton(
          enable: !info.isDeleting.value,
          title: info.isDeleting.value ? '' : deleteStr,
          fontName: FontName.bold,
          bgColor: transparent,
          fontSize: si.isMobile ? 12 : 14,
          leadingIcon: info.isDeleting.value
              ? loadingIndicator(radius: 10)
              : const Icon(
                  Icons.delete,
                  color: red,
                  size: 16,
                ),
          borderColor: red,
          onTap: () {
            con.deleteBlackList(info);
          },
        );
      },
    );
  }

  Column nameAndNumber(BPartyDetailsList info) {
    return Column(
      children: [
        CustomText(
          title: info.bPartyName,
          fontName: FontName.bold,
        ),
        CustomText(
          title: info.bPartyMsisdn,
          color: grey,
        ),
      ],
    );
  }
}
