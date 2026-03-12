import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/side_menu_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

class SideMenuView extends StatefulWidget {
  const SideMenuView({super.key});

  @override
  State<SideMenuView> createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  RxBool isSubMenuOpen = false.obs;
  @override
  initState() {
    // Get.put(SideMenuController());
    // cont = Get.find<SideMenuController>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideMenuWidth,
      decoration: decoration(context),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              itemCount: sideMenuCont.sideMenuList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                  child:
                      // cont.sideMenuList[index].isContainSubMenu
                      //     ? subMenuCard(context, cont.sideMenuList[index]):
                      menuCard(context, sideMenuCont.sideMenuList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomText(
              isSelectable: false,
              title: "@${DateTime.now().year} " + copyrightStr,
            ),
          )
        ],
      ),
    );
  }

  Widget menuCard(BuildContext context, SideMenuModel info, {Color? color}) {
    return InkWell(
      onTap: () {
        if (info.title == darkModeStr) {
          Get.isDarkMode
              ? Get.changeThemeMode(ThemeMode.light)
              : Get.changeThemeMode(ThemeMode.dark);
          StoreManager.setDarkMode(!Get.isDarkMode);
          print(
              "dark mode value: ${StoreManager.isDarkMode} \n get dark mode value: ${Get.isDarkMode}");

          return;
        }
        if (info.title == homeRoute) {
          appCont.mobileBottomNavIndex.value = 0;
        } else if (info.title == searchRoute) {
          appCont.mobileBottomNavIndex.value = 0;
        } else if (info.title == musicBoxRoute) {
          appCont.mobileBottomNavIndex.value = 2;
        } else if (info.title == myWishlistRoute) {
          appCont.mobileBottomNavIndex.value = 3;
        } else if (info.title == myTunesRoute) {
          appCont.mobileBottomNavIndex.value = 4;
        }

        if (info.title == logoutStr) {
          return;
        }
        sideMenuCont.selectedCard.value = info;

        if (info.routeName.isNotEmpty) {
          context.goNamed(info.routeName);
        }
      },
      child: Obx(() {
        //print("info route name: ${info.routeName}");
        return Container(
          decoration: BoxDecoration(
              color: sideMenuCont.selectedCard.value.routeName == info.routeName
                  ? color ?? lightYellow
                  : isDarkTheme(context)
                      ? blackD
                      : lightGrey,
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    isSelectable: false,
                    title: info.title,
                    fontName: sideMenuCont.selectedCard.value.routeName ==
                            info.routeName
                        ? FontName.bold
                        : FontName.regular,
                    // fontSize: sideMenuCont.selectedCard.value.routeName ==
                    //         info.routeName
                    //     ? 16
                    //     : 14,
                  ),
                ),
                info.isContainSubMenu
                    ? Icon(
                        isSubMenuOpen.value
                            ? Icons.expand_more
                            : Icons.chevron_right,
                        size: 20,
                      )
                    : SizedBox()
              ],
            ),
          ),
        );
      }),
    );
  }

  BoxDecoration decoration(BuildContext context) {
    return BoxDecoration(
      color: isDarkTheme(context) ? blackD : white,
      boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.4),
          blurRadius: 4,
          offset: const Offset(0, 4),
        )
      ],
    );
  }

  // Widget subMenuCard(BuildContext context, SideMenuModel info) {
  //   return Obx(() => Container(
  //         // Added Obx so the 'if' actually works
  //         decoration: BoxDecoration(
  //             color: lightYellow, borderRadius: BorderRadius.circular(4)),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Main Card
  //             Row(
  //               children: [
  //                 Expanded(child: menuCard(context, info, color: transparent)),
  //               ],
  //             ),

  //             // Sub Menu Items
  //             (isSubMenuOpen.value) ? subMenuList(context) : const SizedBox()
  //           ],
  //         ),
  //       ));
  // }

  // Widget subMenuList(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: transparent, borderRadius: BorderRadius.circular(4)),
  //       child: ListView.builder(
  //         shrinkWrap: true, // Crucial for use inside a Column
  //         physics:
  //             const NeverScrollableScrollPhysics(), // Let the parent scroll
  //         itemCount: 10, // Use dynamic data
  //         itemBuilder: (context, index) {
  //           //final subItem = info.subItems![index];
  //           return Padding(
  //             padding: const EdgeInsets.only(left: 16.0), // Indent sub-items
  //             child: CustomText(
  //               title: "title",
  //               // Add onTap logic here for sub-items
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
