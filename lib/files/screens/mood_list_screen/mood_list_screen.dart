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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20),
      child: Obx(() {
        return CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: con.moods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 8 : 20.0),
                  child: Column(
                    spacing: isMobile ? 6 : 12,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: con.moods[index].title,
                        fontSize: isMobile ? 18 : 22,
                        fontName: FontName.bold,
                      ),
                      moodDetailList(con.moods[index], index, isMobile),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget moodDetailList(MoodCategory mood, int indx, bool isMobile) {
    return SizedBox(
      height: isMobile ? 220 : 260,
      child: Obx(
        () {
          return mood.isLoading.value
              ? loadingIndicator()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mood.tunes.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: isMobile ? 165 : 195, // 220 * 0.75 = 165
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 6 : 10.0),
                        child: TuneCard(
                            info: mood.tunes[index], tuneList: mood.tunes),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
