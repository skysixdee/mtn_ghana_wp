import 'package:etisalat/files/api_calls/create_blaclist_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/create_blcklist_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/custom_textfield.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/screens/blacklist_screen/create_widget.dart/member_list.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBlacklistScreen extends StatelessWidget {
  CreateBlacklistScreen({super.key});
  TextEditingController nameTextCont = TextEditingController();
  TextEditingController msisdnTextCont = TextEditingController();
  CreateBlaclistController cCont = Get.find();
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            titleHeader(),
            const SizedBox(height: 20),
            Obx(
              () {
                return AbsorbPointer(
                  absorbing: cCont.isLoading.value,
                  child: Flexible(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: lightGrey),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          containerHeader(),
                          Flexible(
                            child: Obx(
                              () {
                                return cCont.memebrList.isEmpty
                                    ? SizedBox()
                                    : memberList(cCont, controller);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Obx(() {
              return cCont.memebrList.isEmpty
                  ? SizedBox()
                  : cCont.isLoading.value
                      ? loadingIndicator()
                      : bottomButtonBuilder(context);
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget bottomButtonBuilder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GenericButton(
          padding: EdgeInsets.symmetric(horizontal: 16),
          title: cancelStr,
          bgColor: transparent,
          borderColor: red,
          onTap: () {
            cCont.memebrList.clear();
          },
        ),
        GenericButton(
          padding: EdgeInsets.symmetric(horizontal: 16),
          title: confirmStr,
          bgColor: yellow,
          onTap: () {
            cCont.onConfirmButtonAction();
          },
        )
      ],
    );
  }

  Widget containerHeader() {
    return Column(
      children: [
        Container(
          height: 100,
          color: myTuneScreenBgColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 700,
                    child: Row(
                      children: [
                        Flexible(
                            child: CustomTextfield(
                                hintText: enterNameStr,
                                controller: nameTextCont,
                                borderColor: transparent,
                                bgColor: white)),
                        const SizedBox(width: 20),
                        Flexible(
                          child: CustomTextfield(
                            hintText: enterMobileNumberStr,
                            borderColor: transparent,
                            bgColor: white,
                            controller: msisdnTextCont,
                            isNumericTextField: true,
                            maxLength: msisdnLength,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                GenericButton(
                  title: addStr,
                  width: 80,
                  borderColor: red,
                  bgColor: transparent,
                  onTap: () async {
                    if (nameTextCont.text.isEmpty) {
                      openAlertPopup(message: enterNameStr);
                      return;
                    }
                    if (msisdnTextCont.text.isEmpty) {
                      openAlertPopup(message: enterMobileNumberStr);
                      return;
                    }

                    cCont.addToList(CreateBlacklistModel(
                        nameTextCont.text, msisdnTextCont.text));
                    nameTextCont.text = '';
                    msisdnTextCont.text = '';
                    await Future.delayed(Duration(milliseconds: 100));
                    controller.jumpTo(controller.position.maxScrollExtent);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget titleHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: blackListStr,
          fontName: FontName.bold,
          fontSize: 18,
        ),
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
            GenericButton(
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
            ),
          ],
        ),
      ],
    );
  }
}
