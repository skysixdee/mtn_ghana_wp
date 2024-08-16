import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/popover_menu_model.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popover/popover.dart';

genericPopover(BuildContext context, List<PopoverMenuModel> menuList,
    {Function(PopoverMenuModel, int)? onTap}) {
  showPopover(
    radius: 4,
    arrowHeight: 6,
    arrowWidth: 16,
    context: context,
    width: 120,
    bodyBuilder: (context) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SizedBox(
              child: ListView.builder(
                itemCount: menuList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (onTap != null) {
                        onTap(menuList[index], index);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            children: [
                              (menuList[index].image != null)
                                  ? Image.asset(menuList[index].image ?? '')
                                  : const SizedBox(),
                              Flexible(
                                child: CustomText(
                                  title: menuList[index].title,
                                  fontName: FontName.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: lightGrey,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
