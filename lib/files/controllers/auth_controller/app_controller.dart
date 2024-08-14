import 'package:etisalat/files/api_calls/get_app_setting.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/utility/urls.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    getAppSetting();
  }
}
