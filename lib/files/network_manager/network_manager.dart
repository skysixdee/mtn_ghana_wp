import 'dart:async';
import 'dart:convert';

import 'package:etisalat/files/api_calls/regenerate_token_api.dart';
import 'package:etisalat/files/model/regenerate_model.dart';
import 'package:etisalat/files/network_manager/request_header.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:universal_io/io.dart';

class NetworkManager {
  final client = HttpClient();
  Future<Map<String, dynamic>> get(String url) async {
    try {
      HttpClientRequest clientRequests = await client.getUrl(Uri.parse(url));

      try {
        clientRequests = await requestHeader(url, clientRequests);
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));
        if (response.statusCode == 498) {
          return await _regenToken(url);
        }
        final stringData = await response.transform(utf8.decoder).join();
        print("resp code is $url \n ${response.statusCode}\n");
        try {
          Map<String, dynamic> valueMap = json.decode(stringData);
          return valueMap;
        } catch (e) {
          print("error5 is = ${e.toString()}");
          return catchError();
        }
      } catch (e) {
        print("error4 is = ${e.toString()}");
        return catchError();
      }
    } on SocketException catch (e) {
      print("error3 is = ${e.toString()}");
      return catchError();
    } on TimeoutException catch (e) {
      print("error2 is = ${e.toString()}");
      return catchError();
    } on Error catch (e) {
      print("error1 is = ${e.toString()}");
      return catchError();
    }
  }

  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? formData, Map<String, dynamic>? jsonData}) async {
    try {
      HttpClientRequest clientRequests = await client.postUrl(Uri.parse(url));

      if (formData != null) {
        var parts = [];
        formData.forEach((key, value) {
          parts.add('$key=' '$value');
        });

        clientRequests.write(parts.join('&'));
      }
      if (jsonData != null) {
        clientRequests.headers
            .set('Content-Type', 'application/json', preserveHeaderCase: true);
        String jsonstringmap = json.encode(jsonData);
        print("print formed data $jsonstringmap");
        clientRequests.write(jsonstringmap);
      }
      try {
        clientRequests = await requestHeader(url, clientRequests);
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));
        if (response.statusCode == 498) {
          return await _regenToken(url, formData: formData, jsonData: jsonData);
        } else {}
        final stringData = await response.transform(utf8.decoder).join();
        print("resp code is $url \n ${response.statusCode}\n");
        try {
          Map<String, dynamic> valueMap = json.decode(stringData);
          return valueMap;
        } catch (e) {
          print("error5 is = ${e.toString()}");
          return catchError();
        }
      } catch (e) {
        print("error4 is = ${e.toString()}");
        return catchError();
      }
    } on SocketException catch (e) {
      print("error3 is = ${e.toString()}");
      return catchError();
    } on TimeoutException catch (e) {
      print("error2 is = ${e.toString()}");
      return catchError();
    } on Error catch (e) {
      print("error1 is = ${e.toString()}");
      return catchError();
    }
  }

  Future<Map<String, dynamic>> _regenToken(String url,
      {Map<String, dynamic>? formData, Map<String, dynamic>? jsonData}) async {
    RegenerateModel mod = await regenerateTokenApi();
    if (mod.statusCode == "SC0000") {
      StoreManager.setAccessToken(mod.responseMap?.accessToken ?? '');
      StoreManager.setRefreshToken(mod.responseMap?.refreshToken ?? '');
      return post(url, formData: formData, jsonData: jsonData);
    } else {
      return catchError();
    }
  }

  Map<String, dynamic> catchError() {
    String someThingWrong = someThingWentWrongStr;
    Map<String, dynamic> valueMap =
        json.decode("""{"message":"$someThingWrong"}""");
    return valueMap;
  }
}
