import 'package:flutter/material.dart';

// class MobileBottomNavView extends StatelessWidget {
//   const MobileBottomNavView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mtn_ghana_wp/files/controllers/side_menu_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

class MobileBottomNavView extends StatelessWidget {
  MobileBottomNavView({super.key});

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      context.goNamed(homeRoute);
    } else if (index == 1) {
      context.goNamed(musicBoxRoute);
    } else if (index == 2) {
      context.goNamed(moodDetectRoute);
    } else if (index == 3) {
      sideMenuCont.selectedCard =
          SideMenuModel(myWishlistStr, myWishlistRoute).obs;
      context.goNamed(myWishlistRoute);
    } else if (index == 4) {
      sideMenuCont.selectedCard = SideMenuModel(myTunezStr, myTunesRoute).obs;
      context.goNamed(myTunesRoute);
    } else {
      context.goNamed(homeRoute);
    }

    appCont.mobileBottomNavIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return BottomNavigationBar(
          iconSize: 20,
          selectedLabelStyle: TextStyle(fontFamily: FontName.bold.name),
          unselectedLabelStyle: TextStyle(fontFamily: FontName.regular.name),
          backgroundColor: isDarkTheme(context) ? blackD : white,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          selectedItemColor: yellow,

          type: BottomNavigationBarType.fixed,
          elevation: 30.0, // Adjust elevation here
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: homeStr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.my_library_music),
              label: musicBoxStr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.face),
              label: moodDetectRoute,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.music_note),
              label: myWishlistStr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: myTunezStr,
            ),
          ],
          currentIndex: appCont.mobileBottomNavIndex.value,
          onTap: (v) {
            _onItemTapped(context, v);
          },
        );
      },
    );
  }
}
