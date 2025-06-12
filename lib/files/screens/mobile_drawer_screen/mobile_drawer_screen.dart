import 'package:mtn_ghana_wp/files/controllers/auth_controller/login_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/category_detail_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/custom_drawer_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/name_tune_controller.dart';
import 'package:mtn_ghana_wp/files/model/drawer_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_popup.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
        color: lightGrey,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return menuList[index].isContainSubMenu
                ? subMenuList(menuList[index].title)
                : mainListCard(context, index);
          },
        ),
      ),
    );
  }

  Widget mainListCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (menuList[index].routeName == loginStr) {
          //print("loginnnnnnnnnnnnnnn");
          LoginController con = Get.find();
          con.resetValue();
          Get.dialog(Obx(
            () {
              return con.displayOptScreen.value
                  ? LoginOtpPopup(
                      securityToken: con.securityToken,
                      isNewUser: con.isNewUser,
                      msisdn: con.msisdn,
                      isMusicBox: false,
                    )
                  : const LoginPopup();
            },
          ));
        } else if (menuList[index].title == logoutStr) {
          //print("logoutttttttttttttttttttttttttttttt");
          StoreManager.logout();
          //context.goNamed(homeRoute);
          // context.goNamed(menuList[index].routeName);
        } else if (menuList[index].title == homeStr) {
          //print("homeeeeeeeeeeeeeee");
          context.goNamed(homeRoute);
        } else if (menuList[index].title == nameTuneStr) {
          NameTuneController con = Get.find();
          con.getNameTune();
          context.goNamed(nameTuneRoute);
        } else if (menuList[index].title == faqStr) {
          context.goNamed(faqRoute);
        } else if (menuList[index].title == profileStr) {
          context.goNamed(profileRoute);
        } else if (menuList[index].title == myTunezStr) {
          TuneController cont = Get.find();
          cont.makeApiCall();
          context.goNamed(myTunesRoute);
        } else if (menuList[index].title == myWishlistStr) {
          context.goNamed(myWishlistRoute);
        } else if (menuList[index].title == blackListStr) {
          context.goNamed(blackListRoute);
        }
      },
      child: Container(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 25),
                  CustomText(
                    title: menuList[index].title,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: white,
            )
          ],
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
            subMenuMainCard(title),
            dCont.isSubMenuOpened.value
                ? Flexible(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: StoreManager.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 60),
                          child: subMenuCard(context, index),
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

  Widget subMenuCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        CategoryDetailController con = Get.find();
        String key = StoreManager.categories?[index].categoryName ?? '';
        String catId = StoreManager.categories?[index].categoryId ?? '';
        context.goNamed(categoryDetailRoute, queryParameters: {
          'key': key,
          'catId': catId,
        });
        con.getCategoryDetailList(key, catId);
      },
      child: Container(
        height: 40,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    title: '${StoreManager.categories?[index].categoryName}',
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: white,
            ),
          ],
        ),
      ),
    );
  }

  Widget subMenuMainCard(String title) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 25),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      dCont.isSubMenuOpened.value =
                          !dCont.isSubMenuOpened.value;
                    },
                    child: CustomText(
                      fontSize: 16,
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
          ),
          Container(
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }
}
