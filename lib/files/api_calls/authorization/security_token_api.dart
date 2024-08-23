import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

getSecurityTokenApi() async {
  Map<String, dynamic> jsonResp = await NetworkManager().get(securityTokenUrl);
}
