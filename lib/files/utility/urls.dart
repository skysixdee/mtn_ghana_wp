//$baseUrl
import 'package:etisalat/files/utility/constants.dart';

String settingUrl = '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/settings';
String featuredUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/get-recommendation-songs?';
String bannerUrl = '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/banner?';
String categoryUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/categories?';

String searchUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/specific-search-tones?";
String bannerDetailUrl =
    "$baseUrl/apigw/Middleware/api/adapter/v1/crbt/banner-search?";
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

String myTunesUrl = '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/list-tones';
String playingTuneUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/list-tones';
String myMusicBoxUrl =
    '$baseUrl/apigw/Middleware/api/adapter/v1/crbt/list-tones';

String tuneSettingFulldayUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/time-based-setting-for-already-activated';
String tuneSettingDedicatedUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/dedicated-user-tone-addition-with-time-setting';
String deleteFromShuffleUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/delete-from-shuffle';
String deleteDedicatedTuneUrl =
    '$baseUrl/security/Middleware/api/adapter/v1/crbt/delete-dedication';
