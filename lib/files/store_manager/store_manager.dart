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
  static String languageCode = '1';
  static String languageSort = 'en';
  static String msisdn = '0';
  static List<Category>? categories;
  static String accessToken = "";
  static String refreshToken = "";
  static String deviceId = '0191212';

  static initValues() {
    msisdn = prefs.getString(_msisdn) ?? '0';
    isLoggedIn = prefs.getBool(_isLoggedIn) ?? false;
    isEnglish = prefs.getBool(_language) ?? true;
    accessToken = prefs.getString(_accessToken) ?? '';
    refreshToken = prefs.getString(_refreshToken) ?? '';
    deviceId = prefs.getString(_deviceId) ?? '0191212';
    language = isEnglish ? "English" : "Burmese";
    appCont.isLoggedIn.value = isLoggedIn;
    languageCode = isEnglish ? '1' : '0';
    languageSort = isEnglish ? 'en' : 'br';
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
    languageCode = isEnglish ? '1' : '0';
    languageSort = isEnglish ? 'en' : 'br';
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
    setMsisdn('0');
    setLoggedIn(false);
    setAccessToken('');
    setRefreshToken('');
    setDeviceId('');
    appCont.isLoggedIn.value = false;
    globalContext.goNamed(homeRoute);
  }
}
