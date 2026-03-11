import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class SideMenuController extends GetxController {
  Rx<SideMenuModel> selectedCard = SideMenuModel(homeStr, homeRoute).obs;
  List<SideMenuModel> sideMenuList = [
    SideMenuModel(homeStr, homeRoute, leadingIconData: CupertinoIcons.home),
    SideMenuModel(myTunezStr, "",
        isContainSubMenu: true,
        leadingIconData: CupertinoIcons.music_note_list),
    SideMenuModel(faqCStr, faqRoute,
        leadingIconData: CupertinoIcons.question_circle),
    SideMenuModel(aboutStr, aboutRoute,
        leadingIconData: CupertinoIcons.info_circle),
    SideMenuModel(rewardPointStr, rewardPointRoute,
        leadingIconData: CupertinoIcons.gift),
  ];
}

class SideMenuModel {
  String title;
  bool isContainSubMenu;
  String routeName;
  Widget? leading;
  Widget? tailing;
  IconData? leadingIconData;
  bool isdivider;
  SideMenuModel(this.title, this.routeName,
      {this.isdivider = false,
      this.isContainSubMenu = false,
      this.leading,
      this.tailing,
      this.leadingIconData});
}
