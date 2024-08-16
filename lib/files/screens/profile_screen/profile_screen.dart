import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/country_code.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/msisdn_textfield.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return ListView(
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: si.isMobile
                          ? Column(
                              children: [
                                profileImage(),
                                deskTopMainContainer(si),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                profileImage(),
                                Flexible(child: deskTopMainContainer(si)),
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
    return si.isMobile
        ? Column(
            children: [
              consfirmButton(),
              const SizedBox(height: 8),
              cancelButton(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              consfirmButton(width: 150),
              const SizedBox(width: 20),
              cancelButton(width: 150)
            ],
          );
  }

  GenericButton cancelButton({double? width}) {
    return GenericButton(
      borderColor: grey,
      width: width,
      title: cancelStr,
      bgColor: lightGrey,
    );
  }

  GenericButton consfirmButton({double? width}) {
    return GenericButton(
      width: width,
      title: confirmStr,
      bgColor: yellow,
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
          width: 180,
          itemCount: 8,
          builder: (p0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(color: yellow)),
                CustomText(title: "title")
              ],
            );
          },
        )
      ],
    );
  }
}
