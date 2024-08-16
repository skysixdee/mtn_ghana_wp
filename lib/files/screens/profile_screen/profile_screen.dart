import 'package:etisalat/files/controllers/profile_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/category_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/country_code.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/msisdn_textfield.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final TextEditingController editingController = TextEditingController();
  ProfileController con = Get.find();
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
                            Flexible(
                              child: SizedBox(
                                width: 1000,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: si.isMobile
                                      ? Column(
                                          children: [
                                            profileImage(),
                                            deskTopMainContainer(si),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            profileImage(),
                                            Flexible(
                                                child:
                                                    deskTopMainContainer(si)),
                                          ],
                                        ),
                                ),
                              ),
                            ),
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

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: yellow,
        ),
        height: 100,
        width: 100,
        child: const Icon(Icons.person),
      ),
    );
  }

  Widget deskTopMainContainer(SizingInformation si) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        msisdnBuilder(),
        Row(
          children: [
            Expanded(child: prefrenceBuilder()),
          ],
        ),
        bottomButtons(si)
      ],
    );
  }

  Widget bottomButtons(SizingInformation si) {
    return Obx(
      () {
        return si.isMobile
            ? Column(
                children: [
                  consfirmButton(),
                  const SizedBox(height: 8),
                  con.enableEdit.value ? cancelButton() : SizedBox(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  consfirmButton(width: 150),
                  const SizedBox(width: 20),
                  con.enableEdit.value ? cancelButton(width: 150) : SizedBox()
                ],
              );
      },
    );
  }

  GenericButton cancelButton({double? width}) {
    return GenericButton(
      borderColor: grey,
      width: width,
      title: cancelStr,
      bgColor: lightGrey,
      onTap: () {
        con.onCancelButtonAction();
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
            con.onConfirmTapButtonAction();
          },
        );
      },
    );
  }

  Widget msisdnBuilder() {
    editingController.text = StoreManager.msisdn;

    return Row(
      children: [
        Flexible(
            child: SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: contactNumberStr,
                      fontName: FontName.regular,
                      color: grey,
                      fontSize: 12,
                    ),
                    MsisdnTextfield(
                      controller: editingController,
                      enabled: false,
                      leadingChild: countryCode(),
                    ),
                  ],
                ))),
      ],
    );
  }

  Widget prefrenceBuilder() {
    List<Category> lst = StoreManager.categories ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          title: preferenceStr,
          fontName: FontName.regular,
        ),
        GenericGridView(
          height: 120,
          width: 150,
          itemCount: lst.length,
          onTap: (index) {
            con.updateChoice(lst[index].categoryId ?? '');
          },
          builder: (p0) {
            return preferenceCard(lst, p0);
          },
        )
      ],
    );
  }

  Widget preferenceCard(List<Category> lst, int p0) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: customImage(
                    url: lst[p0].menuImagePath, gredientColor: gredientColor),
              ),
              redioButton(lst, p0)
            ],
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
          return con.selectedCetegories.contains(lst[p0].categoryId)
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
