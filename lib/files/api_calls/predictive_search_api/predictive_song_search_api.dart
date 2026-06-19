import 'dart:convert';

import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:mtn_ghana_wp/files/model/predictive_search_model.dart';

Future<List<String>> predictiveSongSearchApi(String query) async {
  try {
    List<String> stringList = [];
    String url =
        "$predictiveSearchUrl/selfcare/predictive/english-content-search/autocomplete/contentname?q=$query";
    Map<String, dynamic> jsonMap =
        await NetworkManager().get(url, addInHeader: [
      {'Authorization': predictiveAuthorization}
    ]);

    PredictSearchModel model =
        PredictSearchModel.fromJson(jsonMap, query.replaceAll(" ", "\\"));

    // PredictSearchModel model =
    //     PredictSearchModel.fromJson(json.decode(_jsonData), "s");

    for (Suggestion itm
        in model.suggest?.autoCompleteSuggester?.searchKey?.suggestions ?? []) {
      stringList.add(itm.payload ?? '');
    }
    return stringList;
  } catch (e) {
    print("error in predictive search api: $e");
    return [];
  }
}

String _jsonData = """{
  "responseHeader":{
    "zkConnected":true,
    "status":0,
    "QTime":4},
  "suggest":{"autoCompleteSuggester":{
      "s":{
        "numFound":50,
        "suggestions":[{
            "term":"Poe <b>S</b>o Pas <b>S</b>at Ver 1",
            "weight":0,
            "payload":"Poe So Pas Sat Ver 1"},
          {
            "term":"Ma Taw Ta <b>S</b>a",
            "weight":0,
            "payload":"Ma Taw Ta Sa"},
          {
            "term":"Min Yee <b>S</b>ar Verse",
            "weight":0,
            "payload":"Min Yee Sar Verse"},
          {
            "term":"Ka Bar Thone Yee <b>S</b>ar <b>S</b>a Kar Ver 1",
            "weight":0,
            "payload":"Ka Bar Thone Yee Sar Sa Kar Ver 1"},
          {
            "term":"<b>S</b>awe Kyoe Ver 1",
            "weight":0,
            "payload":"Sawe Kyoe Ver 1"},
          {
            "term":"<b>S</b>awe Kyoe Ver 2",
            "weight":0,
            "payload":"Sawe Kyoe Ver 2"},
          {
            "term":"Car <b>S</b>ote Kyi",
            "weight":0,
            "payload":"Car Sote Kyi"},
          {
            "term":"<b>S</b>hane Ver 1",
            "weight":0,
            "payload":"Shane Ver 1"},
          {
            "term":"Tit Ka Pyan <b>S</b>a Mal",
            "weight":0,
            "payload":"Tit Ka Pyan Sa Mal"},
          {
            "term":"Thway <b>S</b>oon A Chit",
            "weight":0,
            "payload":"Thway Soon A Chit"},
          {
            "term":"<b>S</b>one Taw Myai",
            "weight":0,
            "payload":"Sone Taw Myai"},
          {
            "term":"Mi Thar <b>S</b>u",
            "weight":0,
            "payload":"Mi Thar Su"},
          {
            "term":"A <b>s</b>one Hti",
            "weight":0,
            "payload":"A sone Hti"},
          {
            "term":"Nya Yae <b>S</b>ue",
            "weight":0,
            "payload":"Nya Yae Sue"},
          {
            "term":"<b>S</b>one Ma",
            "weight":0,
            "payload":"Sone Ma"},
          {
            "term":"Chit Kan <b>S</b>oe",
            "weight":0,
            "payload":"Chit Kan Soe"},
          {
            "term":"<b>S</b>hweManMarLarAY",
            "weight":0,
            "payload":"ShweManMarLarAY"},
          {
            "term":"Khan <b>S</b>ar Chat",
            "weight":0,
            "payload":"Khan Sar Chat"},
          {
            "term":"A <b>S</b>one That Tot",
            "weight":0,
            "payload":"A Sone That Tot"},
          {
            "term":"A Nee <b>S</b>one Lu 2",
            "weight":0,
            "payload":"A Nee Sone Lu 2"},
          {
            "term":"A Chit Myar <b>S</b>war Yu Ver 1",
            "weight":0,
            "payload":"A Chit Myar Swar Yu Ver 1"},
          {
            "term":"Kan <b>S</b>one Kwint",
            "weight":0,
            "payload":"Kan Sone Kwint"},
          {
            "term":"Kyauk <b>S</b>it A Thel",
            "weight":0,
            "payload":"Kyauk Sit A Thel"},
          {
            "term":"Chit <b>S</b>way",
            "weight":0,
            "payload":"Chit Sway"},
          {
            "term":"Kyo <b>S</b>o Par Ei",
            "weight":0,
            "payload":"Kyo So Par Ei"},
          {
            "term":"Thaw Ka Lat <b>S</b>ot",
            "weight":0,
            "payload":"Thaw Ka Lat Sot"},
          {
            "term":"Khin Lay <b>S</b>ein Tal",
            "weight":0,
            "payload":"Khin Lay Sein Tal"},
          {
            "term":"A Nee <b>S</b>one Lu Unplugged",
            "weight":0,
            "payload":"A Nee Sone Lu Unplugged"},
          {
            "term":"<b>S</b>al Lal Tan",
            "weight":0,
            "payload":"Sal Lal Tan"},
          {
            "term":"Yout <b>S</b>oe Ma",
            "weight":0,
            "payload":"Yout Soe Ma"},
          {
            "term":"Note <b>S</b>at Par Tal",
            "weight":0,
            "payload":"Note Sat Par Tal"},
          {
            "term":"Mat Lout <b>S</b>a Yar",
            "weight":0,
            "payload":"Mat Lout Sa Yar"},
          {
            "term":"A Lwan <b>S</b>u Lat",
            "weight":0,
            "payload":"A Lwan Su Lat"},
          {
            "term":"Pyan <b>S</b>one Twae Kya Par <b>S</b>ot",
            "weight":0,
            "payload":"Pyan Sone Twae Kya Par Sot"},
          {
            "term":"Ngar Toe A Twal Wine <b>S</b>u",
            "weight":0,
            "payload":"Ngar Toe A Twal Wine Su"},
          {
            "term":"<b>S</b>hwe Lat Twal Verse",
            "weight":0,
            "payload":"Shwe Lat Twal Verse"},
          {
            "term":"Remote Control <b>S</b>ai <b>S</b>ai",
            "weight":0,
            "payload":"Remote Control Sai Sai"},
          {
            "term":"<b>S</b>ain Pyay Lite Tan",
            "weight":0,
            "payload":"Sain Pyay Lite Tan"},
          {
            "term":"<b>S</b>ait <b>S</b>haw",
            "weight":0,
            "payload":"Sait Shaw"},
          {
            "term":"Ngar A Twat Ate <b>S</b>at Chin",
            "weight":0,
            "payload":"Ngar A Twat Ate Sat Chin"},
          {
            "term":"<b>S</b>uu <b>S</b>uu Mhar <b>S</b>o Loz",
            "weight":0,
            "payload":"Suu Suu Mhar So Loz"},
          {
            "term":"Chee Monn Kya <b>S</b>ay",
            "weight":0,
            "payload":"Chee Monn Kya Say"},
          {
            "term":"<b>S</b>ar Lan Tha Chin",
            "weight":0,
            "payload":"Sar Lan Tha Chin"},
          {
            "term":"<b>S</b>aut Nay Tae Ngar",
            "weight":0,
            "payload":"Saut Nay Tae Ngar"},
          {
            "term":"Thit <b>S</b>ar Pay",
            "weight":0,
            "payload":"Thit Sar Pay"},
          {
            "term":"Nin Ma <b>S</b>hi Top Yin",
            "weight":0,
            "payload":"Nin Ma Shi Top Yin"},
          {
            "term":"Kyoe <b>S</b>arr Tine",
            "weight":0,
            "payload":"Kyoe Sarr Tine"},
          {
            "term":"Thit <b>S</b>ar Ma Pyat Kyae",
            "weight":0,
            "payload":"Thit Sar Ma Pyat Kyae"},
          {
            "term":"Myaw Lint Chat Ta <b>S</b>one Ta Yar Ver 2",
            "weight":0,
            "payload":"Myaw Lint Chat Ta Sone Ta Yar Ver 2"},
          {
            "term":"Kam Ma <b>S</b>hi Tae A Chit",
            "weight":0,
            "payload":"Kam Ma Shi Tae A Chit"}]}}}}
""";
