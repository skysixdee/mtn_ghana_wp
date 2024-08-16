import 'dart:async';
import 'dart:convert';

import 'package:etisalat/files/network_manager/request_header.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:universal_io/io.dart';

class NetworkManager {
  final client = HttpClient();
  Future<Map<String, dynamic>> get(String url) async {
    try {
      HttpClientRequest clientRequests = await client.getUrl(Uri.parse(url));
      clientRequests = await requestHeader(url, clientRequests);
      try {
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));

        final stringData = await response.transform(utf8.decoder).join();
        print("resp code is ${response.statusCode}");
        Map<String, dynamic> valueMap = json.decode(stringData);
        return valueMap;
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
      clientRequests = await requestHeader(url, clientRequests);
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
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));

        final stringData = await response.transform(utf8.decoder).join();
        print("resp code is ${response.statusCode}");
        Map<String, dynamic> valueMap = json.decode(stringData);
        return valueMap;
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

  Map<String, dynamic> catchError() {
    String someThingWrong = someThingWentWrongStr;
    Map<String, dynamic> valueMap =
        json.decode("""{"message":"$someThingWrong"}""");
    return valueMap;
  }
}
