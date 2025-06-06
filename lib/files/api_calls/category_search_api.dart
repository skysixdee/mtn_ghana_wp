 import 'package:mtn_ghana_wp/files/model/advanced_search_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<AdvancedSearchModal> categorySearchApi(String categoryId, {int pageNo=0}) async{

  Map<String, dynamic> jsonRequest={
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "locale":StoreManager.languageCode, //"${LANGUAGE_ID}",
    "categoryId":[categoryId],


};
Map<String, dynamic> jsonResponse=await 
NetworkManager().post(
 categorySearchScUrl, 
 //"https://run.mocky.io/v3/3c31c197-f3db-43ed-833f-bd279ad93791",
jsonData: jsonRequest);
AdvancedSearchModal advancedSearchModal=AdvancedSearchModal.fromJson(jsonResponse);

return advancedSearchModal;
 }