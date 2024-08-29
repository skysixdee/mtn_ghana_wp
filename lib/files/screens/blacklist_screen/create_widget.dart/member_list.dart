import 'package:etisalat/files/api_calls/create_blaclist_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/create_blcklist_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget memberList(
  CreateBlaclistController cCont,
  ScrollController? controller,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: listHeader(),
        ),
        Flexible(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: grey),
                color: white),
            child: Obx(
              () {
                return ListView.builder(
                  controller: controller,
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: cCont.memebrList.length,
                  itemBuilder: (context, index) {
                    return listCard(cCont.memebrList[index], cCont, 0 == index);
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget listHeader() {
  return SizedBox(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          fontName: FontName.bold,
          title: nameStr,
        ),
        CustomText(
          fontName: FontName.bold,
          title: mobileNumberStr,
        ),
        CustomText(
          title: removeStr,
          fontName: FontName.bold,
        )
      ],
    ),
  );
}

Widget listCard(CreateBlacklistModel info, CreateBlaclistController cCont,
    bool hideDivider) {
  return Container(
    height: 50,
    child: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Container(
                  color: red,
                  child: CustomText(
                    title: info.name,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: yellow,
                    child: Center(
                      child: CustomText(
                        textAlign: TextAlign.center,
                        title: info.msisdn,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: GenericButton(
                    padding: EdgeInsets.zero,
                    width: 40,
                    height: 45,
                    leadingIcon: const Icon(Icons.close, size: 18),
                    onTap: () {
                      cCont.deleteMember(info);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: hideDivider ? transparent : lightGrey,
          height: 1,
        )
      ],
    ),
  );
}
