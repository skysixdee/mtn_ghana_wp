import 'package:mtn_ghana_wp/files/model/drawer_model.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  List<DrawerModel> loggedInDrawerMenu = [
    DrawerModel(homeStr, homeRoute),
    DrawerModel(profileStr, profileRoute),
    DrawerModel(myTunezStr, myTunesRoute),
    DrawerModel(myWishlistStr, myWishlistRoute),
    DrawerModel(tunezStr, '', isContainSubMenu: true),
    DrawerModel(nameTuneStr, nameTuneRoute),
    DrawerModel(blackListStr, blackListRoute),
    DrawerModel(faqStr, faqRoute),
    DrawerModel(logoutStr, logoutStr),
  ];
  List<DrawerModel> nonLoggedInDrawerMenu = [
    DrawerModel(homeStr, homeRoute),
    DrawerModel(tunezStr, tunezStr, isContainSubMenu: true),
    DrawerModel(nameTuneStr, nameTuneRoute),
    DrawerModel(faqStr, faqRoute),
    DrawerModel(loginStr, loginStr),
  ];
  RxBool isSubMenuOpened = false.obs;
}
