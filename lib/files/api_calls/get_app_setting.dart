import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/app_setting_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

getAppSettingApi() async {
  Map<String, dynamic> map = await NetworkManager().get(settingScUrl);
  AppSettingModel appSettingModel = appSettingModelFromJson(json.encode(map));
  //AppSettingModel appSettingModel = appSettingModelFromJson(_settingResp);
  StoreManager.other =
      appSettingModel; //appSettingModel.responseMap?.settings?.others;
  print(
      "----------------------gokul----------------${jsonEncode(appSettingModel.toJson())}");
}

String _settingResp = """{
  "CONTACT_US": {
    "enable": false,
    "attribute": "customercare@mtn.sd"
  },
  "APP_SHARE_LINK": {
    "enable": false,
    "attribute": "iOS,https://www.apple.com/in/app-store/|android,https://play.google.com/store/apps"
  },
  "CRBT_TONE_CHARGE": {
    "enable": false,
    "attribute": "en,Rp. 0|id,Rp. 0"
  },
  "ARTIST_LIST_ARABIC": {
    "enable": false,
    "attribute": "Arijit,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2455&isMobileBanner=1&isEnglish=1|Sonu Nigham,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2465&isMobileBanner=1&isEnglish=1|Kumar Sanu,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2467&isMobileBanner=1&isEnglish=1|KK,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2453&isMobileBanner=1&isEnglish=1"
  },
  "ARTIST_LIST_ENGLISH": {
    "enable": false,
    "attribute": "Arijit,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2455&isMobileBanner=1&isEnglish=1|Sonu Nigham,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2465&isMobileBanner=1&isEnglish=1|Kumar Sanu,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2467&isMobileBanner=1&isEnglish=1|KK,https://mouzikti.mobi/stream-media/get-banner-image?bannerId=2453&isMobileBanner=1&isEnglish=1"
  },
  "FEATURED_CAT_ARABIC": {
    "enable": false,
    "attribute": "New Releases,NewReleases,2,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=11|Trending,Trending,2,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=22|Love Songs,Love,2,https://mouzikti.mobi/stream-media/get-category-menu-image?menuId=43|Pop Hits,pop,2,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=96|TOP Songs,JUST_FOR_YOU,2,https://mouzikti.mobi/stream-media/get-category-menu-image?menuId=7"
  },
  "FEATURED_CAT_ENGLISH": {
    "enable": false,
    "attribute": "Top20,Top20,164,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=11|New Releases,NewReleases,165,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=11|Pop,Pop,166,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=22|Hip Pop,hiphop,167,https://mouzikti.mobi/stream-media/get-category-menu-image?menuId=43|Hip Life,hiplife,168,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=96|Gospels,Gospels,169,https://mouzikti.mobi/stream-media/get-category-menu-image?menuId=7|Rock,Rock,170,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=11|Regge,Regge,52,https://ringtune.mpt.com.mm/stream-media/get-category-menu-image?menuId=11"
  },
  "LANGUAGE_LIST_ARABIC": {
    "enable": false,
    "attribute": "en,|ar,"
  },
  "PRIVACY_TERMS_ARABIC": {
    "enable": false,
    "attribute": "*Terms & Conditions*,.,https://www.mtn.com/legal|*Privacy Policy*,.,https://www.mtn.com/legal/tablink=privacy_policy"
  },
  "LANGUAGE_LIST_ENGLISH": {
    "enable": false,
    "attribute": "en,English|ar,Arabic"
  },
  "NAME_TUNE_CATEGORY_ID": {
    "enable": false,
    "attribute": "47"
  },
  "PRIVACY_TERMS_ENGLISH": {
    "enable": false,
    "attribute": "*Terms & Conditions*,Please refer to the following link for detailed terms.,https://www.mtn.com/legal|*Privacy Policy*,Please refer the following link for detailed privacy policy.,https://www.mtn.com/legal/?tablink=privacy_policy"
  },
  "MOOD_LIST_ARABIC": {
    "enable": false,
    "attribute": "44,Neutral,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=11|64,Happy,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=22|53,Sad,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=96|48,Angry,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Fearful,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Disgusted,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Surprised,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Relaxed,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Relieved,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Screaming,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101"
  },
  "MOOD_LIST_ENGLISH": {
    "enable": false,
    "attribute": "44,Neutral,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=11|64,Happy,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=22|53,Sad,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=96|48,Angry,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Fearful,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Disgusted,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Surprised,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Relaxed,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Relieved,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101|48,Screaming,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101"
  },
  "CATEGORIES_LIST_ARABIC": {
    "enable": false,
    "attribute": "44,Myanmar Rock,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=11|64,Myanmar Pop,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=22|53,Myanmar Dance Music,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=96|48,Rnb Music,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101"
  },
  "CATEGORIES_LIST_ENGLISH": {
    "enable": false,
    "attribute": "44,Myanmar Rock,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=11|64,Myanmar Pop,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=22|53,Myanmar Dance Music,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=96|48,Rnb Music,https://funtone.ooredoo.com.mm/stream-media/get-category-menu-image?menuId=101"
  },
  "CRBT_SUBSCRIPTION_PACKS_ENG": {
    "enable": false,
    "attribute": "Mazazik SDG 30/Month"
  },
  "CRBT_SUBSCRIPTION_PACKS_ARABIC": {
    "enable": false,
    "attribute": "/SDG"
  }
}""";
