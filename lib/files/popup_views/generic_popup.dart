import 'package:flutter/material.dart';
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
    pageBuilder: (_, __, ___) => Center(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
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
          ],
        ),
      ),
    ),
  );
}
