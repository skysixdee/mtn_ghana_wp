import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/model/regenerate_model.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/api_calls/regenerate_token_api.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/network_manager/request_header.dart';

class NetworkManager {
  final client = HttpClient();
  Future<Map<String, dynamic>> get(String url,
      {List<Map<String, dynamic>>? addInHeader}) async {
    try {
      HttpClientRequest clientRequests = await client.getUrl(Uri.parse(url));
      if (addInHeader != null) {
        for (Map<String, dynamic> element in addInHeader) {
          Map<String, dynamic> abc = element.map(
            (key, value) {
              clientRequests.headers.set(key, value, preserveHeaderCase: true);
              return MapEntry(key, value);
            },
          );
          print("==== $abc");
        }
      }
      try {
        clientRequests = await requestHeader(url, clientRequests);
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));
        if (response.statusCode == 498) {
          return await _regenToken(url);
        }
        if (response.statusCode == 401) {
          StoreManager.logout();
        }
        final stringData = await response.transform(utf8.decoder).join();
        customPrint("resp code is $url \n ${response.statusCode}\n");
        try {
          Map<String, dynamic> valueMap = json.decode(stringData);
          return valueMap;
        } catch (e) {
          customPrint("error5 is = ${e.toString()}\n and strin is $stringData");
          return catchError();
        }
      } catch (e) {
        customPrint("error4 is = ${e.toString()}");
        return catchError(message: e.toString());
      }
    } on SocketException catch (e) {
      customPrint("error3 is = ${e.toString()}");
      return catchError();
    } on TimeoutException catch (e) {
      customPrint("error2 is = ${e.toString()}");
      return catchError();
    } on Error catch (e) {
      customPrint("error1 is = ${e.toString()}");
      return catchError();
    }
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? formData,
    Map<String, dynamic>? jsonData,
    List<Map<String, dynamic>>? addInHeader,
  }) async {
    try {
      HttpClientRequest clientRequests = await client.postUrl(Uri.parse(url));
//addInHeader
      if (formData != null) {
        clientRequests.headers.set('Content-Type', 'application/x-www-form-urlencoded',
      preserveHeaderCase: true);
        var parts = [];
        formData.forEach((key, value) {
          // parts.add('${Uri.encodeQueryComponent(key)}='
          //     '${Uri.encodeQueryComponent("$value")}');
          // parts.add('$key='
          //     "$value");
          parts.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}');
        });

        clientRequests.write(parts.join('&'));
      }
      if (addInHeader != null) {
        for (Map<String, dynamic> element in addInHeader) {
          Map<String, dynamic> abc = element.map(
            (key, value) {
              clientRequests.headers.set(key, value, preserveHeaderCase: true);
              return MapEntry(key, value);
            },
          );
          print("==== $abc");
        }
      }
      if (jsonData != null) {
        clientRequests.headers
            .set('Content-Type', 'application/json', preserveHeaderCase: true);
        String jsonstringmap = json.encode(jsonData);
        customPrint("customPrint formed data $jsonstringmap");
        clientRequests.write(jsonstringmap);
      }
      try {
        clientRequests = await requestHeader(url, clientRequests);
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));
        if (response.statusCode == 498) {
          return await _regenToken(url, formData: formData, jsonData: jsonData);
        }
        if (response.statusCode == 401) {
          StoreManager.logout();
        }
        final stringData = await response.transform(utf8.decoder).join();
        customPrint("resp code is $url \n ${response.statusCode}\n");
        try {
          Map<String, dynamic> valueMap = json.decode(stringData);
          return valueMap;
        } catch (e) {
          customPrint("error5 is = ${e.toString()}\n and strin is $stringData");
          return catchError();
        }
      } catch (e) {
        customPrint("error4 is = ${e.toString()}");
        return catchError(message: e.toString());
      }
    } on SocketException catch (e) {
      customPrint("error3 is = ${e.toString()}");
      return catchError();
    } on TimeoutException catch (e) {
      customPrint("error2 is = ${e.message}");
      return catchError();
    } on Error catch (e) {
      customPrint("error1 is = ${e.toString()}");
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

  Map<String, dynamic> catchError({String message = ''}) {
    String someThingWrong = someThingWentWrongStr;
    Map<String, dynamic> valueMap =
        json.decode("""{"message":"$someThingWrong"}""");
    return valueMap;
  }
}
