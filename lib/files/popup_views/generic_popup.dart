import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

genericPopup(Widget widget) {
  if (scaffoldKey.currentContext == null) {
    print("Context path is null so not opening popup");
    return;
  }
  showGeneralDialog(
    context: scaffoldKey.currentContext!,
    barrierDismissible: false,
    barrierLabel: 'Dismiss',
    barrierColor: Get.context == null
        ? black.withOpacity(0.6)
        : (isDarkTheme(Get.context!)
            ? white.withOpacity(0.4)
            : black.withOpacity(0.6)),
    pageBuilder: (_, __, ___) => Center(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(color: transparent, child: widget
                      // Obx(
                      //   () {
                      //     return con.displayOptScreen.value
                      //         ? LoginOtpPopup(
                      //             securityToken: con.securityToken,
                      //             isNewUser: con.isNewUser,
                      //             msisdn: con.msisdn,
                      //             isMusicBox: false,
                      //           )
                      //         : const LoginPopup();
                      //   },
                      // ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
