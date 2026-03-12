import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_on_hover.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popover/popover.dart';

genericPopover(BuildContext context, List<PopoverMenuModel> menuList,
    {double width = 120,
    Color? barrierColor,
    Function(PopoverMenuModel, int)? onTap}) {
  showPopover(
    barrierColor: barrierColor ?? Color(0x80000000),
    radius: 4,
    arrowHeight: 6,
    arrowWidth: 16,
    context: context,
    width: width,
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
                  return InkWell(onTap: () async {
                    if (onTap != null) {
                      Navigator.of(context).pop();
                      await Future.delayed(const Duration(milliseconds: 300));
                      onTap(menuList[index], index);
                    }
                  }, child: CustomOnHover(
                    builder: (isHovered) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1.0, vertical: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isHovered ? yellow : white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: Row(
                                  children: [
                                    (menuList[index].image != null)
                                        ? Image.asset(
                                            menuList[index].image ?? '')
                                        : const SizedBox(),
                                    Flexible(
                                      child: CustomText(
                                        isSelectable: false,
                                        title: menuList[index].title,
                                        fontName: FontName.regular,
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
                        ),
                      );
                    },
                  ));
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
