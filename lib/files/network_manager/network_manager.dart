import 'dart:async';
import 'dart:convert';

import 'package:etisalat/files/utility/constants.dart';
import 'package:universal_io/io.dart';

class NetworkManager {
  final client = HttpClient();
  Future<Map<String, dynamic>> get(String url) async {
    try {
      print("Sky ===1");
      HttpClientRequest clientRequests = await client.getUrl(Uri.parse(url));
      print("SKy ===3 ");
      try {
        HttpClientResponse response = await clientRequests
            .close()
            .timeout(const Duration(seconds: timeOutDuration));
        print("SKy ===2 ");
        final stringData = await response.transform(utf8.decoder).join();
        print("resp code is ${response.statusCode}");
        Map<String, dynamic> valueMap = json.decode(stringData);
        return valueMap;
      } catch (e) {
        print("Catched error ===5 $e");
        Map<String, dynamic> valueMap =
            json.decode("""{"message":"Socket Error: ${e.toString()}"}""");
        return valueMap;
      }
    } on SocketException catch (e) {
      print("Catched error ===2 $e");
      Map<String, dynamic> valueMap =
          json.decode("""{"message":"Socket Error: ${e.toString()}"}""");
      return valueMap;
    } on TimeoutException catch (e) {
      print("Catched error ===3 $e");
      Map<String, dynamic> valueMap =
          json.decode("""{"message":"Timeout Error: ${e.toString()}"}""");
      return valueMap;
    } on Error catch (e) {
      print("Catched error ===4 $e");
      print("error is ${e.toString()}");
      Map<String, dynamic> valueMap =
          json.decode("""{"message":"${e.toString()}"}""");
      return valueMap;
    }
  }
}
