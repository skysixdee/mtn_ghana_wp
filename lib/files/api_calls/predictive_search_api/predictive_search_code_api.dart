import 'package:mtn_ghana_wp/files/api_calls/tone_code_search_api.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';

Future<List<TuneInfo>> predictiveSearchCodeApi(String query) async {
  SearchResultModel model = await getToneCodeSearchListApi(query);
  return model.responseMap?.toneList ?? [];
}
