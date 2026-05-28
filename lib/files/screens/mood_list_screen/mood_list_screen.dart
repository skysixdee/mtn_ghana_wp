import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/mood_list_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MoodListScreen extends StatefulWidget {
  const MoodListScreen({super.key});

  @override
  State<MoodListScreen> createState() => _MoodListScreenState();
}

class _MoodListScreenState extends State<MoodListScreen> {
  late MoodListController con;
  @override
  void initState() {
    Get.lazyPut(() => MoodListController());
    con = Get.find<MoodListController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: con.moods.length,
          itemBuilder: (context, index) {
            return Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: con.moods[index].title,
                  fontSize: 18,
                  fontName: FontName.bold,
                ),
                moodDetailList(con.moods[index], index)
              ],
            );
          },
        );
      },
    );
  }

  Widget moodDetailList(MoodCategory mood, int indx) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return SizedBox(
          height: si.isMobile ? 220 : 260,
          child: Obx(
            () {
              return mood.isLoading.value
                  ? loadingIndicator()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: mood.tunes.length,
                      itemBuilder: (context, index) {
                        return AspectRatio(
                            aspectRatio: 0.75,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TuneCard(
                                  info: mood.tunes[index],
                                  tuneList: mood.tunes),
                            ));
                      },
                    );
            },
          ),
        );
      },
    );
  }
}
