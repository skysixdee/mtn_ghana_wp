import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_search_textfield.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/music_box_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/buttons/from_time_button.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/buttons/to_time_button.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/buttons/when_play_button.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/selectable_repeat_section_view.dart';
import 'package:etisalat/files/screens/my_tune_setting_screen/widgets/whom_selection_view.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:etisalat/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:go_router/go_router.dart';
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
    print("initState MyTuneSettingController");
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MyTuneSettingController>();
    print("Disposed MyTuneSettingController");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, si) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: si.isMobile
                ? mobileMainContainer(si)
                : desktopMainContainer(si),
          );
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whomSelectionView(con),
                    const SizedBox(height: 20),
                    CustomText(
                      title: enterFriendMobileNumberStr,
                    ),
                    CustomSearchTextfield(
                      isNumericTextField: true,
                      maxLength: msisdnLength,
                      width: 400,
                      radius: 4,
                      hintColor: grey,
                      hintText: enterFriendMobileNumberStr,
                      controller: TextEditingController(),
                      trailingChild: const SizedBox(),
                    )
                  ],
                ),
              ),
              Container(
                color: myTuneScreenBgColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      CustomText(
                        title: whenYouWantToPlayItStr,
                        fontName: FontName.bold,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 8),
                      whenPlaySection(si),
                      const SizedBox(height: 20),
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
          onTap: () {
            context.goNamed(myTunesRoute);
          },
        )
      ],
    );
  }

  Widget whenPlaySection(SizingInformation si) {
    return MediaQuery.of(context).size.width < 1000
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 220, child: WhenPlayButton()),
              const SizedBox(height: 10),
              timeButtons(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [WhenPlayButton(), timeButtons()],
          );
  }

  Row timeButtons() {
    return Row(
      children: [
        fromTimeButton(con),
        const SizedBox(width: 10),
        toTimeButton(con),
      ],
    );
  }
}
