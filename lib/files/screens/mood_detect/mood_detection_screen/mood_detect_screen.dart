import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_detection_screen/widgets/md_tune_list_section.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_detection_screen/widgets/md_upload_pic_section.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/moods_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MoodDetectScreen extends StatefulWidget {
  const MoodDetectScreen({super.key});

  @override
  State<MoodDetectScreen> createState() => _MoodDetectScreenState();
}

class _MoodDetectScreenState extends State<MoodDetectScreen> {
  MoodsController cont = Get.find();
  @override
  void initState() {
    cont.loadModelFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? Obx(
                () {
                  return Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      MdUploadPicSection(),
                      if (cont.imageBytes.value != null ||
                          cont.isMoodTapped.value)
                        Container(
                            color: appCont.isDarkTheme.value ? blackD : white,
                            child: MdTuneListSection())
                    ],
                  );
                },
              )
            : Row(
                children: [
                  Expanded(child: MdUploadPicSection()),
                  Container(
                    width: 1,
                    color: lightGrey,
                  ),
                  Expanded(child: MdTuneListSection())
                ],
              );
      },
    );
  }
}
