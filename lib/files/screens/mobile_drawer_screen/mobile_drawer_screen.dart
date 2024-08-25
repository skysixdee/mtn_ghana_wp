import 'package:etisalat/files/controllers/custom_drawer_controller.dart';
import 'package:etisalat/files/model/drawer_model.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileDrawerScreen extends StatelessWidget {
  MobileDrawerScreen({super.key});
  CustomDrawerController dCont = Get.find();
  List<DrawerModel> menuList = [];
  @override
  Widget build(BuildContext context) {
    menuList = StoreManager.isLoggedIn
        ? dCont.loggedInDrawerMenu
        : dCont.nonLoggedInDrawerMenu;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        color: yellow,
        child: ListView.builder(
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return menuList[index].isContainSubMenu
                ? subMenuList(menuList[index].title)
                : CustomText(
                    title: menuList[index].title,
                    fontSize: 18,
                  );
          },
        ),
      ),
    );
  }

  Widget subMenuList(String title) {
    return Obx(
      () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      dCont.isSubMenuOpened.value =
                          !dCont.isSubMenuOpened.value;
                    },
                    child: CustomText(
                      fontSize: 18,
                      title: title,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                )
              ],
            ),
            dCont.isSubMenuOpened.value
                ? Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: StoreManager.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 30),
                          child: Container(
                            height: 40,
                            color: white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    title:
                                        '${StoreManager.categories?[index].categoryName}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
