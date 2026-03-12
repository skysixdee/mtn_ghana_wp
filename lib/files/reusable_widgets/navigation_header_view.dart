import 'package:mtn_ghana_wp/files/model/navigation_header_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/music_box_card.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationHeaderView extends StatelessWidget {
  const NavigationHeaderView(
      {super.key, required this.titleList, this.onTap, this.rightButton});
  final List<NavigationHeaderModel> titleList;
  final Function(int)? onTap;
  final Widget? rightButton;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? const SizedBox()
            : Container(
                color: isDarkTheme(context) ? blackD : lightGrey,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: si.isMobile ? 8.0 : 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: titleList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            return GenericButton(
                              textColorD: whiteD,
                              padding: const EdgeInsets.only(right: 4),
                              bgColor: transparent,
                              textColor: index == (titleList.length - 1)
                                  ? black
                                  : grey,
                              title: titleList[index].name,
                              trailingIcon: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: (index == (titleList.length - 1))
                                    ? const SizedBox()
                                    : Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: index == (titleList.length - 1)
                                            ? black
                                            : grey,
                                        size: 14,
                                      ),
                              ),
                              onTap: (index == (titleList.length - 1))
                                  ? null
                                  : () {
                                      if (index == (titleList.length - 1)) {
                                        return;
                                      }
                                      if (titleList[index].routeName != null) {
                                        if (onTap != null) {
                                          onTap!(index);
                                        } else {
                                          context.goNamed(
                                              titleList[index].routeName!,
                                              extra: titleList[index].extra);
                                        }
                                      }
                                    },
                            );
                          },
                        ),
                      ),
                      rightButton ?? SizedBox()
                    ],
                  ),
                ),
              );
      },
    );
  }
}
