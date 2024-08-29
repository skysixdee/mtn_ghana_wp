import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:google_tag_manager/google_tag_manager.dart' as gtm;

loggedUserBuyWithdrawEvent(TuneInfo info) {
  gtm.pushEvent('LoggedUser_Buy_Withdraw', data: {
    "msisdn": StoreManager.msisdn,
    "tone_id": info.toneId,
    "category_id": info.categoryId,
    "tone_name": info.toneName,
  });
}

buySuccessfulEvent(TuneInfo info) {
  gtm.pushEvent('Buy_Successful', data: {
    "msisdn": StoreManager.msisdn,
    "tone_id": info.toneId,
    "category_id": info.categoryId,
    "tone_name": info.toneName,
  });
}

purchaseEvent(TuneInfo info) {
  gtm.pushEvent('purchase', data: {
    "msisdn": StoreManager.msisdn,
    "tone_id": info.toneId,
    "category_id": info.categoryId,
    "tone_name": info.toneName,
  });
}

buyOTPWithdrawEvent(TuneInfo info) {
  gtm.pushEvent('Buy_OTP_Withdraw', data: {
    "msisdn": StoreManager.msisdn,
    "tone_id": info.toneId,
    "category_id": info.categoryId,
    "tone_name": info.toneName,
  });
}

buyClickWithdrawEvent(TuneInfo info) {
  gtm.pushEvent('Buy_Click_Withdraw', data: {
    "msisdn": StoreManager.msisdn,
    "tone_id": info.toneId,
    "category_id": info.categoryId,
    "tone_name": info.toneName,
  });
}

buyClickEvent(TuneInfo info) {
  gtm.pushEvent('Buy_Click', data: {
    "msisdn": StoreManager.msisdn,
    "tone_id": info.toneId,
    "category_id": info.categoryId,
    "tone_name": info.toneName,
  });
}

tunePlayClickEvent(TuneInfo info) {
  gtm.pushEvent('Tune_Play_Click', data: {
    "tone_id": info.toneId,
    "tone_name": info.toneName,
    "artist_name": info.artistName,
    "album_name": info.albumName,
    "category_id": info.categoryId,
    "msisdn": StoreManager.msisdn,
  });
}

homePageCategoryBrowseEvent(String searchKey, String catId, String catName) {
  gtm.pushEvent('HomePage_Category_Browse', data: {
    "category_id": catId,
    "category_name": catName,
    "msisdn": StoreManager.msisdn,
  });
}

homePageSearchClickEvent(String searchKey) {
  gtm.pushEvent('HomePage_Search_Click', data: {
    "search_key": searchKey,
  });
}

homePageBannerClickEvent(String bannerId) {
  gtm.pushEvent('HomePage_Banner_Click', data: {
    "banner_id": bannerId,
    "msisdn": StoreManager.msisdn,
  });
}

homePageBrowseEvent() {
  gtm.pushEvent('HomePage_Browse');
}

menuCategoryClickEvent(String catId, String catName) {
  gtm.pushEvent('Menu_Category_Click', data: {
    "category_id": catId,
    "category_name": catName,
  });
}

menuFaqClickEvent() {
  gtm.pushEvent('Menu_FAQ_Click', data: {
    "msisdn": StoreManager.msisdn,
  });
}

loginSuccessfulEvent(String msisdn) {
  gtm.pushEvent('Login_Successful', data: {
    "msisdn": msisdn,
  });
}

homePageHeFootPrintEvent(String msisdn) {
  gtm.pushEvent('HomePage_HE_Footprint', data: {
    "msisdn": msisdn,
  });
}
