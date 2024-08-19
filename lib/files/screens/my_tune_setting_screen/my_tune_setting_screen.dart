import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/buttons/from_time_button.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/buttons/to_time_button.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/buttons/when_play_button.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/selectable_repeat_section_view.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/whom_selection_view.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:etisalat/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTuneSettingScreen extends StatefulWidget {
  const MyTuneSettingScreen({super.key, required this.info});
  final TuneInfo info;
  @override
  State<MyTuneSettingScreen> createState() => _MyTuneSettingScreen1State();
}

class _MyTuneSettingScreen1State extends State<MyTuneSettingScreen> {
  late MyTuneSettingController con;
  @override
  void initState() {
    con = Get.put(MyTuneSettingController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MyTuneSettingScreen>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, si) {
          return si.isMobile
              ? mobileMainContainer(si)
              : desktopMainContainer(si);
        },
      ),
    );
  }

  Widget desktopMainContainer(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tuneImage(),
          const SizedBox(width: 30),
          Flexible(child: SizedBox(width: 700, child: mainContaner(si)))
        ],
      ),
    );
  }

  Padding mobileMainContainer(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tuneImage(),
            ],
          ),
          mainContaner(si),
        ],
      ),
    );
  }

  Widget tuneImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: customImage(
              url: widget.info.toneIdpreviewImageUrl, cornerRadius: 4),
        ),
        const SizedBox(height: 4),
        CustomText(
          title: widget.info.toneName ?? '',
          fontName: FontName.bold,
        ),
        CustomText(
          title: widget.info.albumName ?? '',
          color: myTuneScreenBgColor,
        ),
      ],
    );
  }

  Widget mainContaner(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: lightGrey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: whomSelectionView(),
              ),
              Container(
                color: myTuneScreenBgColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      whenPlaySection(si),
                      repeatContainerView(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        bottomButtons(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget repeatContainerView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                title: repeatStr,
                fontSize: 12,
              ),
              const SizedBox(height: 4),
              SelectableRepeatSectionView()
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomButtons() {
    return Row(
      children: [
        GenericButton(
          width: 150,
          height: 35,
          radius: 4,
          bgColor: yellow,
          title: confirmStr,
          onTap: () {},
        ),
        const SizedBox(width: 10),
        GenericButton(
          height: 35,
          width: 150,
          radius: 4,
          bgColor: white,
          title: cancelStr,
          borderColor: myTuneScreenBgColor,
          onTap: () {},
        )
      ],
    );
  }

  Widget whenPlaySection(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: MediaQuery.of(context).size.width < 800
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 220, child: WhenPlayButton()),
                SizedBox(height: 10),
                timeButtons(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [WhenPlayButton(), timeButtons()],
            ),
    );
  }

  Row timeButtons() {
    return Row(
      children: [
        fromTimeButton(),
        const SizedBox(width: 10),
        toTimeButton(),
      ],
    );
  }
}
