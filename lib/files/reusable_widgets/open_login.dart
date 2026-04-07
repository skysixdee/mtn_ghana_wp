import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/auth_controller/login_controller.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_popup.dart';

openLogin() {
  LoginController con = Get.find();
  con.resetValue();
  genericPopup(Obx(
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
}
