import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/side_menu_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

class SideMenuView extends StatefulWidget {
  const SideMenuView({super.key});

  @override
  State<SideMenuView> createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  late SideMenuController cont;
  RxBool isSubMenuOpen = false.obs;
  @override
  initState() {
    Get.put(SideMenuController());
    cont = Get.find<SideMenuController>();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SideMenuController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideMenuWidth,
      decoration: decoration(),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        itemCount: cont.sideMenuList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
            child: cont.sideMenuList[index].isContainSubMenu
                ? subMenuCard(context, cont.sideMenuList[index])
                : menuCard(context, cont.sideMenuList[index]),
          );
        },
      ),
    );
  }

  Widget menuCard(BuildContext context, SideMenuModel info, {Color? color}) {
    return InkWell(
      onTap: () {
        cont.selectedCard.value = info;
        if (info.isContainSubMenu) {
          isSubMenuOpen.value = !isSubMenuOpen.value;
        } else {
          isSubMenuOpen.value = false;
        }
        if (info.routeName.isNotEmpty) {
          //Get.toNamed(info.routeName);
          context.goNamed(info.routeName);
        }
      },
      child: Obx(() {
        return Container(
          decoration: BoxDecoration(
              color: cont.selectedCard.value.title == info.title
                  ? color ?? lightYellow
                  : lightGrey,
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    title: info.title,
                    fontName: cont.selectedCard.value.title == info.title
                        ? FontName.semiBold
                        : FontName.regular,
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

  BoxDecoration decoration() {
    return BoxDecoration(
      color: white,
      boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.4),
          blurRadius: 4,
          offset: const Offset(0, 4),
        )
      ],
    );
  }

  Widget subMenuCard(BuildContext context, SideMenuModel info) {
    return Obx(() => Container(
          // Added Obx so the 'if' actually works
          decoration: BoxDecoration(
              color: lightYellow, borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main Card
              Row(
                children: [
                  Expanded(child: menuCard(context, info, color: transparent)),
                ],
              ),

              // Sub Menu Items
              (isSubMenuOpen.value) ? subMenuList(context) : const SizedBox()
            ],
          ),
        ));
  }

  Widget subMenuList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: transparent, borderRadius: BorderRadius.circular(4)),
        child: ListView.builder(
          shrinkWrap: true, // Crucial for use inside a Column
          physics:
              const NeverScrollableScrollPhysics(), // Let the parent scroll
          itemCount: 10, // Use dynamic data
          itemBuilder: (context, index) {
            //final subItem = info.subItems![index];
            return Padding(
              padding: const EdgeInsets.only(left: 16.0), // Indent sub-items
              child: CustomText(
                title: "title",
                // Add onTap logic here for sub-items
              ),
            );
          },
        ),
      ),
    );
  }
}
