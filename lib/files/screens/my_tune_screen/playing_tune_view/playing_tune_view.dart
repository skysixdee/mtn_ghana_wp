import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/screens/my_tune_screen/playing_tune_view/widgets/playing_tune_card.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayingTuneView extends StatelessWidget {
  PlayingTuneView({super.key});
  final MyPlayingTuneController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoading.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: con.toneDetails.length,
                builder: (p0) {
                  return PlayingTuneCard(info: con.toneDetails[p0].first);
                },
              );
      },
    );
  }
}
