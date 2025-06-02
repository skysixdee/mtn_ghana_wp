//$baseUrl
import 'package:mtn_ghana_wp/files/utility/constants.dart';

String categoryUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/categories?';
String bannerUrl = '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/banner?';
String featuredUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/get-recommendation-songs?';
String bannerDetailUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/banner-search?";
String settingUrl = '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/settings';
String addToneToShuffleUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/add-tone-to-shuffle";
String deleteFromShuffleUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/delete-from-shuffle';
String myTunesUrl = '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/list-tones';
String playingTuneUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/list-tones';
String deleteDedicatedTuneUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/delete-dedication';
String artistTuneSearchUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/search-tone?';
String deleteMyTuneUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/delete-tone";
String sendGiftUrl = "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/send-gift";
String getTonePriceUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/get-tone-price";
String generateOtpUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/generate-otp';
String confirmOtpUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/confirm-otp';

//-------------------------couldn't find--------------------------
String searchUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones?";
String categoryDetailUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/search-tone?';
String myWishistUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/view-wishlist';
String addToWishlistUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/add-to-wishlist';
String deleteFromWishlistUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/delete-from-wishlist';
String reGenerateTokenUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/regen-token';
String profileDetailUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/get-profile-details";
String editProfileUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/edit-profile";
String packDetailUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/pack-status?';
String nameTuneUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones?';
String musicBoxUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/music-box-search?";
String musicBoxContextUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/music-box-contents?';
String myMusicBoxUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/list-tones';
String tuneSettingFulldayUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/time-based-setting-for-already-activated';
String tuneSettingDedicatedUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/dedicated-user-tone-addition-with-time-setting';
String shuffleEnableDisableUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/shuffle-activation-deactivation';
String subscriberValidationUrl ="http://10.135.64.104:8021/apigw/Middleware/api/adapter/v1/crbt/subscriber-validation";
    //'$baseUrl/apigw/Middleware/api/adapter/v1/crbt/subscriber-validation';

String passwordValidateUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/password-validation';
String securityTokenUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/security-token';
String setToneUrl = "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/set-tone";
String searchNameTuneUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones';
String getBlackListUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/view-black-list';
String createBlackListUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/add-to-black-list';
String deleteBlacklistUrl =
    "$baseUrl/security/Middleware/api/adapter/v1/crbt/remove-from-black-list";
String buyMusicChannelUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/buy-music-channel";
String checkOtpNewUserUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/otp-check";


//----------------------selfcare api url--------------------------
String advancedSearchScUrl="http://10.0.14.4:8090/advanced-search";
String bannerDetailScUrl="http://10.0.14.4:5892/selfcare/get-banner-details?";
String addToneToShuffleScUrl="http://10.135.64.101:51004/selfcare/setting-service/add-tone-to-shufflelist";
String deleteFromShuffleScUrl="http://10.135.64.101:51004/selfcare/setting-service/delete-tone-from-shufflelist";
String settingScUrl= "";
String categoryScUrl="";
String bannerScUrl="";
String categorySearchScUrl="";

String myTunesScUrl="http://10.135.64.101:53004/selfcare/subscriber-management/list-tones";
String deleteDedicatedTuneScUrl =
    'http://10.135.64.101:51012/selfcare/subscriber-management/delete-dedication';
String artistTuneSearchScUrl= "http://10.135.64.101:53008/selfcare/artist-search";
String deleteMyTuneScUrl="http://10.135.64.101:51012/selfcare/subscriber-management/delete-tone";
String sendGiftScUrl="http://10.135.64.101:51009/selfcare/subscriber-management/gift-tone";
String getTonePriceScUrl="http://10.135.64.101:53004/selfcare/subscriber-management/get-content-price";

//--------------------------from old selfcare document--------------------------
String myWishistScUrl = 
    '$baseUrl/selfcare/wishlist-service/get-wishlist';
String generateOtpScUrl =
    '$authBaseUrl/auth-service/selfcare/auth/otp';
String confirmOtpScUrl =
    '$authBaseUrl/auth-service/selfcare/auth/token';