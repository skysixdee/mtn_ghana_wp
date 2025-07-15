//$baseUrl
import 'package:mtn_ghana_wp/files/utility/constants.dart';

String artistTuneSearchUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/search-tone?';

String categoryMwUrl = "";

//-------------------------couldn't find--------------------------
String searchUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones?";

String myWishistUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/view-wishlist';

String reGenerateTokenUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/regen-token';
String profileDetailUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/get-profile-details";
String editProfileUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/edit-profile";

String nameTuneUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones?';
String musicBoxUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/music-box-search?";
//"https://mytune.atom.com.mm/apigw/Middleware/api/adapter/v1/crbt/music-box-search?";
String musicBoxContextUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/music-box-contents?';

String tuneSettingFulldayUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/time-based-setting-for-already-activated';

String subscriberValidationUrl =
    "http://10.135.64.104:8021/apigw/Middleware/api/adapter/v1/crbt/subscriber-validation";
//'$baseUrl/apigw/Middleware/api/adapter/v1/crbt/subscriber-validation';

String passwordValidateUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/password-validation';
String securityTokenUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/security-token';

String searchNameTuneUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones';
String getBlackListUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/view-black-list';
String createBlackListUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/add-to-black-list';
String deleteBlacklistUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/remove-from-black-list";

String checkOtpNewUserUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/otp-check";

//----------------------selfcare api url--------------------------
String bannerDetailScUrl = '';
//"http://10.0.14.4:5892/selfcare/get-banner-details?";
String tuneSettingDedicatedUrl = '';
String listSettingUrl = '';
String deleteFromWishlistUrl = "";

String buyMusicChannelUrl = "";

String addToneToShuffleScUrl = "";

String getSubscriptionUrl = "";

String shuffleEnableDisableUrl = '';

String categoryDetailUrl = "";
String playingTuneUrl = '';
String myTunesUrl = '';
String myMusicBoxUrl = '';
String artistsSearchUrl = '';
String advanceSearchUrl = '';

String deleteMusicBoxSubscriptionUrl = '';
String deleteMyTuneUrl = "";

String deleteDedicatedTuneUrl = "";

String addToWishlistUrl = "";

String setToneUrl = "";
String myWishistScUrl = "";
String generateOtpScUrl = '$authBaseUrl/auth-service/selfcare/auth/otp';
String confirmOtpScUrl = '$authBaseUrl/auth-service/selfcare/auth/token';

String deleteFromShuffleScUrl = '';
//"http://10.135.64.101:51004/selfcare/setting-service/delete-tone-from-shufflelist";
String settingScUrl = "";
String sendGiftScUrl = '';
//"http://10.135.64.101:51009/selfcare/subscriber-management/gift-tone";
String getBannerListScUrl = "";
String categorySearchScUrl = "";
String getCategoryListUrl = '';
String getMusicBoxListUrl = "";
String getMusicBoxToneListUrl = '';
// String deleteDedicatedTuneScUrl =
//     'http://10.135.64.101:51012/selfcare/subscriber-management/delete-dedication';
// String artistTuneSearchScUrl =
//     "http://10.135.64.101:53008/selfcare/artist-search";
// String deleteMyTuneScUrl =
//     "http://10.135.64.101:51012/selfcare/subscriber-management/delete-tone";

String getTonePriceScUrl = '';

//--------------------------from old selfcare document--------------------------
