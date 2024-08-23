import 'package:etisalat/files/controllers/tune_search_controller.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.searchKey});
  final String searchKey;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// class SearchScreen extends StatelessWidget {

  final TuneSearchController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    controller.getResult(widget.searchKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.isLoading.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: controller.tuneList.length,
                builder: (p0) {
                  return TuneCard(
                      info: controller.tuneList[p0],
                      tuneList: controller.tuneList);
                },
              );
      },
    );
  }
}
