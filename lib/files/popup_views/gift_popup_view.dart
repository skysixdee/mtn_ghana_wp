import 'package:mtn_ghana_wp/files/controllers/gift_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/popup_views/popup_tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/country_code.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_textfield.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/error_message_widget.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';

import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GiftPopupView extends StatefulWidget {
  const GiftPopupView({super.key, required this.info});
  final TuneInfo info;

  @override
  State<GiftPopupView> createState() => _GiftPopupViewState();
}

class _GiftPopupViewState extends State<GiftPopupView> {
  TextEditingController textEditingController = TextEditingController();
  late GiftController con;
  @override
  void initState() {
    Get.lazyPut(() => GiftController());
    con = Get.find();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ResponsiveBuilder(
            builder: (context, si) {
              return Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: white,
                  ),
                  width: popupWidth,
                  child: ListView(
                    shrinkWrap: true,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      headerView(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: si.isMobile
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            popupToneDetailAndCharge(widget.info, si, false),
                            const SizedBox(height: 20),
                            msisdnTextFieldBuilder(si),
                            Obx(
                              () {
                                return errorMessageBuilder(
                                    message: con.messsage.value);
                              },
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return con.isLoading.value
                                  ? loadingIndicator()
                                  : buttonsBuilder(si);
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget msisdnTextFieldBuilder(SizingInformation si) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: enterFriendMobileNumberStr),
        Obx(
          () {
            return CustomTextfield(
              enabled: !con.isLoading.value,
              hintText: enterFriendMobileNumberStr,
              controller: textEditingController,
              leadingChild: countryCodeWidget(),
              maxLength: msisdnLength,
              isNumericTextField: true,
              onChange: (p0) {
                con.updateMsisdn(p0);
              },
              onSubmit: (p0) {
                con.onConfirmButtonAction(widget.info);
                con.onDismiss = () {
                  Navigator.pop(context);
                };
              },
            );
          },
        )
      ],
    );
  }

  Widget buttonsBuilder(SizingInformation si) {
    return si.isMobile
        ? Column(
            children: [
              confirmButton(),
              const SizedBox(height: 8),
              cancelButton(),
            ],
          )
        : Row(
            children: [
              Expanded(child: confirmButton()),
              const SizedBox(width: 15),
              Expanded(child: cancelButton()),
            ],
          );
  }

  Widget cancelButton() {
    return GenericButton(
      title: cancelStr,
      borderColor: grey,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget confirmButton() {
    return GenericButton(
      title: confirmStr,
      bgColor: yellow,
      onTap: () {
        con.onConfirmButtonAction(widget.info);
        con.onDismiss = () {
          Navigator.pop(context);
        };
      },
    );
  }

  Widget headerView() {
    return Container(
      color: lightGrey,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 2, top: 2, bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(title: giftStr, fontName: FontName.bold, fontSize: 18),
            GenericButton(
              padding: EdgeInsets.zero,
              height: 35,
              width: 30,
              bgColor: transparent,
              leadingIcon: const Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
