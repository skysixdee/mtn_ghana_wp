import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:mtn_ghana_wp/files/encrypt/cryptom.dart';
import 'package:mtn_ghana_wp/files/model/newUserRegistrationModel.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

Future<NewUserRegistrationModel> newUserRegistration(
      String msisdn, String securityCounter) async {
    print("entered newUserRegistration method \n the msisdn is $msisdn");
    String url ="${baseUrl}/apigw/Middleware/api/adapter/v1/crbt/registration"; //Constants.newUserRegistrationUrl;
    String encryptedPassword = Cryptom().text("Oem@L#@1");

    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    var myPost = {
      "msisdn": msisdn,
      "encryptedPassword": encryptedPassword,
      "language":"English", //StoreManager().selectedLanguage,
      "clientTxnId": '$randomNumber',
      "userName": msisdn,
      "email": "",
      "categoryId": "137",
      "securityCounter": securityCounter,
    };
    // var parts = [];
    // myPost.forEach((key, value) {
    //   parts.add('${Uri.encodeQueryComponent(key)}='
    //       '${Uri.encodeQueryComponent(value)}');
    // });
    // var formData = parts.join('&');
    // print('\n=======\n========\n');
    // print("\nformed data is \n$formData\n");
    // print('\n=======\n========\n');
    // final client = HttpClient();
    // var request = await client.postUrl(Uri.parse(url));
    // //ServiceCall().httpServiceCall(request);
    // request = await Header().settingHeader(url, request);
    // request.write(formData);
    // HttpClientResponse response = await request.close();

    // final stringData = await response.transform(utf8.decoder).join();
    // print(stringData);

    // print('response.statusCode = ${response.statusCode}');
    Map<String, dynamic> jsonResp= await
    NetworkManager().post(url, formData: myPost);
    // Map<String, dynamic> valueMap = json.decode(stringData);
    NewUserRegistrationModel model =
        NewUserRegistrationModel.fromJson(jsonResp);
    return model;
  }