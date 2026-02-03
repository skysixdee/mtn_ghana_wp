import 'package:mtn_ghana_wp/files/controllers/profile_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/reward_point_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/category_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/country_code.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_textfield.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';

import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController editingController = TextEditingController();

  ProfileController con = Get.find();
  late RewardPointController rewardCon;
  @override
  void initState() {
    Get.lazyPut(() => RewardPointController());
    rewardCon = Get.find();
    rewardCon.getRewardPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return Obx(
            () {
              return con.isLoading.value
                  ? loadingIndicator()
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(child: mainContainer(si)),
                          ],
                        )
                      ],
                    );
            },
          );
        },
      ),
    );
  }

  SizedBox mainContainer(SizingInformation si) {
    return SizedBox(
      width: 1000,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: mobileColumn(
              si) //si.isMobile ? mobileColumn(si) : deskTopLeftWidgt(si),
          ),
    );
  }

  Column mobileColumn(SizingInformation si) {
    return Column(
      children: [
        profileImage(si),
        //deskTopMainContainer(si),
      ],
    );
  }

  Widget rewardPointWiddget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(title: rewardPointStr + " : ", fontName: FontName.bold),
        Obx(
          () {
            return rewardCon.isLoading.value
                ? loadingIndicator(radius: 12)
                : CustomText(
                    title: "${rewardCon.resp.value.rewardPoints}",
                    fontName: FontName.regular);
          },
        )
      ],
    );
  }

  Row deskTopLeftWidgt(SizingInformation si) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        profileImage(si),
        // Flexible(
        //     child: Padding(
        //   padding: const EdgeInsets.symmetric(
        //     vertical: 40.0,
        //   ),
        //   child: deskTopMainContainer(si),
        // )),
      ],
    );
  }

  Widget profileImage(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: yellow,
            ),
            height: 100,
            width: 100,
            child: const Icon(Icons.person),
          ),
          const SizedBox(height: 20),
          SizedBox(width: 250, child: deskTopMainContainer(si)),
          //status(),

          rewardPointWiddget(),
          const SizedBox(height: 8),
          table(),
          //subscriptionPlanWidget(),

          const SizedBox(height: 8),
          subscribeAndUnSubscribeButton()
        ],
      ),
    );
  }

  table() {
    return con.packsList.isEmpty
        ? const CustomText(
            title: "No Pack Active",
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(color: grey),
                borderRadius: BorderRadius.circular(4)),
            width: 300,
            child: Column(
              children: [
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: subscriptionPlanStr,
                        fontName: FontName.bold,
                      ),
                      CustomText(
                        title: statusStr,
                        fontName: FontName.bold,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 1,
                    color: grey,
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  shrinkWrap: true,
                  itemCount: con.packsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subscriptionPlanWidget(con.packsList[index].packName),
                          status(con.packsList[index].isActive),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ));
  }

  Widget subscriptionPlanWidget(String packName) {
    return CustomText(
      title: packName,
      fontName: FontName.bold,
      fontSize: 12,
    );
    Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(title: "$subscriptionPlanStr : "),
          CustomText(
            title: packName,
            fontName: FontName.bold,
          ),
        ],
      ),
    );
  }

  Widget status(bool isActive) {
    return CustomText(
      title: !isActive ? inActiveStr : activeStr,
      color: !isActive ? red : const Color.fromARGB(255, 14, 184, 20),
      fontName: FontName.bold,
      fontSize: 12,
    );
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          title: "$statusStr : ",
          //fontName: FontName.bold,
        ),
        //const SizedBox(height: 4),
        CustomText(
          title: !isActive ? inActiveStr : activeStr,
          color: !isActive ? red : const Color.fromARGB(255, 14, 184, 20),
          fontName: FontName.bold,
        )
      ],
    );
  }

  Widget subscribeAndUnSubscribeButton() {
    return Obx(
      () {
        return con.isSubscribing.value
            ? loadingIndicator()
            : GenericButton(
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                title: !con.isActive ? subscribeStr : unSubscribeStr,
                bgColor: !con.isActive ? green : red,
                textColor: white,
                onTap: () {
                  if (!con.isActive) {
                    con.subscribeButtonAction();
                  } else {
                    con.unSubscribeButtonAction();
                  }
                  print("tapped");
                },
              );
      },
    );
  }

  Widget deskTopMainContainer(SizingInformation si) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          msisdnBuilder(si),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: prefrenceBuilder(si)),
            ],
          ),
          //const SizedBox(height: 30),
          //bottomButtons(si)
        ],
      ),
    );
  }

  Widget bottomButtons(SizingInformation si) {
    return Obx(
      () {
        return con.isUpdating.value
            ? loadingIndicator()
            : si.isMobile
                ? bottomButtonsColumn()
                : bottomButtonsRow();
      },
    );
  }

  Padding bottomButtonsColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          consfirmButton(),
          const SizedBox(height: 8),
          con.enableEdit.value ? cancelButton() : const SizedBox(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Row bottomButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        consfirmButton(width: 150),
        const SizedBox(width: 20),
        con.enableEdit.value ? cancelButton(width: 150) : SizedBox()
      ],
    );
  }

  GenericButton cancelButton({double? width}) {
    return GenericButton(
      borderColor: grey,
      width: width,
      title: cancelStr,
      bgColor: lightGrey,
      onTap: () {
        //con.onCancelButtonAction();
      },
    );
  }

  Widget consfirmButton({double? width}) {
    return Obx(
      () {
        return GenericButton(
          width: width,
          title: con.enableEdit.value ? confirmStr : editStr,
          bgColor: yellow,
          onTap: () {
            //con.onConfirmTapButtonAction();
          },
        );
      },
    );
  }

  Widget msisdnBuilder(SizingInformation si) {
    editingController.text = StoreManager.msisdn;

    return Row(
      children: [
        Flexible(
            child: SizedBox(
                width: si.isMobile ? double.infinity : 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: contactNumberStr,
                      fontName: FontName.regular,
                      color: grey,
                      fontSize: 12,
                    ),
                    const SizedBox(height: 4),
                    CustomTextfield(
                      clearIcon: const SizedBox(),
                      controller: editingController,
                      trailingChild: const SizedBox(),
                      enabled: false,
                      leadingChild: countryCodeWidget(),
                    ),
                  ],
                ))),
      ],
    );
  }

  Widget prefrenceBuilder(SizingInformation si) {
    List<Category> lst = StoreManager.categories ?? [];
    return SizedBox();
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          title: preferenceStr,
          fontName: FontName.regular,
        ),
        const SizedBox(height: 4),
        si.isMobile ? customWrap() : gridView(lst)
      ],
    );
  }

  Widget customWrap() {
    return (StoreManager.categories == null)
        ? const SizedBox()
        : Wrap(
            spacing: 8,
            runSpacing: 8,
            children: StoreManager.categories!
                .map((e) => categoryNameCard(e))
                .toList(),
          );
  }

  Widget categoryNameCard(Category e) {
    return InkWell(
      onTap: () {
        con.updateChoice(e.categoryId ?? '');
      },
      child: Obx(
        () {
          bool isSelected = con.selectedCetegories.contains(e.categoryId);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: grey),
              color: isSelected ? yellow : white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: CustomText(title: e.categoryName ?? ''),
            ),
          );
        },
      ),
    );
  }

  Widget gridView(List<Category> lst) {
    return CombinedGrid(
        itemCount: lst.length,
        cardWidth: 150,
        aspectRatio: 1.2,
        onTap: (p1) {
          print("index tapped ");
        },
        builder: (p0) {
          return preferenceCard(lst, p0);
        });
    // tuneGridView(
    //   itemCount: lst.length,
    //   aspectRatio: 1.2,
    //   cardWidth: 120,
    //   onTap: (index) {
    //     con.updateChoice(lst[index].categoryId ?? '');
    //   },
    //   builder: (p0) {
    //     return preferenceCard(lst, p0);
    //   },
    // );
    // GenericScrollView(
    //   cardHeight: 120,
    //   cardWidth: 110,
    //   childAspectRatio: 1.2,
    //   padding: EdgeInsets.zero,
    //   onlyGrid: true,
    //   itemCount: lst.length,
    //   onTap: (index) {
    //     con.updateChoice(lst[index].categoryId ?? '');
    //   },
    //   builder: (p0) {
    //     return preferenceCard(lst, p0);
    //   },
    // );
  }

  Widget preferenceCard(List<Category> lst, int p0) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Obx(
            () {
              return InkWell(
                onTap: con.enableEdit.value
                    ? () {
                        con.updateChoice(lst[p0].categoryId ?? '');
                        print("object");
                      }
                    : null,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: customImage(
                          url: lst[p0].menuImage,
                          gredientColor: black.withOpacity(0.4)),
                    ),
                    redioButton(lst, p0)
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          title: lst[p0].categoryName ?? '',
        )
      ],
    );
  }

  Widget redioButton(List<Category> lst, int p0) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Obx(
        () {
          bool isSel = con.selectedCetegories.contains(lst[p0].categoryId);
          return isSel
              ? const Icon(
                  Icons.radio_button_checked,
                  color: yellow,
                )
              : const Icon(
                  Icons.radio_button_unchecked,
                  color: yellow,
                );
        },
      ),
    );
  }
}
