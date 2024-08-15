import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/country_code.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/msisdn_textfield.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GiftPopupView extends StatefulWidget {
  const GiftPopupView({super.key, required this.info});
  final TuneInfo info;

  @override
  State<GiftPopupView> createState() => _GiftPopupViewState();
}

class _GiftPopupViewState extends State<GiftPopupView> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
        color: transparent,
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
                          tuneImage(),
                          const SizedBox(height: 20),
                          tuneDetail(si),
                          const SizedBox(height: 10),
                          tuneCharge(si),
                          const SizedBox(height: 20),
                          msisdnTextFieldBuilder(si),
                          const SizedBox(height: 20),
                          buttonsBuilder(si),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget tuneDetail(SizingInformation si) {
    return Column(
      crossAxisAlignment:
          si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        CustomText(title: widget.info.toneName ?? ''),
        CustomText(
          title: widget.info.artistName ?? '',
          color: grey,
        ),
      ],
    );
  }

  Widget tuneCharge(SizingInformation si) {
    String price = StoreManager.other?.tonePrice?.attribute ?? '';
    return Column(
      crossAxisAlignment:
          si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        CustomText(title: tuneChargeStr),
        CustomText(
          title: price,
          color: grey,
        ),
      ],
    );
  }

  Widget msisdnTextFieldBuilder(SizingInformation si) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: enterFriendMobileNumberStr),
        MsisdnTextfield(
          hintText: enterFriendMobileNumberStr,
          controller: textEditingController,
          leadingChild: countryCode(),
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
    );
  }

  Widget tuneImage() {
    return SizedBox(
      height: 150,
      child:
          customImage(url: widget.info.toneIdpreviewImageUrl, cornerRadius: 8),
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
