import 'package:etisalat/files/model/app_setting_model.dart';
import 'package:etisalat/files/model/category_model.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/main.dart';
import 'package:go_router/go_router.dart';

const String _accessToken = 'access_token';
const String _refreshToken = 'refresh_token';
const String _deviceId = 'device_id';
const String _msisdn = 'msisdn';
const String _language = 'language';
const String _isLoggedIn = 'is_logged_in';

class StoreManager {
  static Others? other;
  static bool isLoggedIn = true;
  static bool isEnglish = true;
  static String language = 'English';
  static String languageCode = '0';
  static String msisdn = '0832120732';
  static List<Category>? categories;
  static String accessToken = "884c12da-9613-4bbb-b865-ba2a2e9cfcee";
  static String refreshToken = "7004d11a-7d1d-4808-aeb9-910e9e10283c";
  static String deviceId = '73585278-e909-413f-ab44-55145496baec';

  static initValues() {
    msisdn = prefs.getString(_msisdn) ?? '';
    isLoggedIn = prefs.getBool(_isLoggedIn) ?? false;
    isEnglish = prefs.getBool(_language) ?? true;
    accessToken = prefs.getString(_accessToken) ?? '';
    refreshToken = prefs.getString(_refreshToken) ?? '';
    deviceId = prefs.getString(_deviceId) ?? '';
    language = isEnglish ? "English" : "Burmese";
    appCont.isLoggedIn.value = isLoggedIn;
  }

  static setMsisdn(String value) {
    prefs.setString(_msisdn, value);
    msisdn = value;
  }

  static setLoggedIn(bool value) {
    prefs.setBool(_isLoggedIn, value);
    isLoggedIn = value;
    appCont.isLoggedIn.value = isLoggedIn;
  }

  static setLanguageEnglish(bool value) {
    prefs.setBool(_language, value);
    language = value ? 'English' : "Burmese";
    isEnglish = value;
  }

  static setAccessToken(String value) {
    prefs.setString(_accessToken, value);
    accessToken = value;
  }

  static setRefreshToken(String value) {
    prefs.setString(_refreshToken, value);
    refreshToken = value;
  }

  static setDeviceId(String value) {
    prefs.setString(_deviceId, value);
    deviceId = value;
  }

  static logout() {
    setMsisdn('');
    setLoggedIn(false);
    setAccessToken('');
    setRefreshToken('');
    setDeviceId('');
    appCont.isLoggedIn.value = false;
    globalContext.goNamed(homeRoute);
  }
}
