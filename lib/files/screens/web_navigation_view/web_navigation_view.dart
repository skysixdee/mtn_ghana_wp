import 'package:etisalat/files/controllers/app_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_image.dart';
import 'package:etisalat/files/reusable_widgets/custom_search_textfield.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/msisdn_textfield.dart';

import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebNavigationView extends StatelessWidget {
  WebNavigationView({super.key});
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: yellow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: leftWidget()),
            Flexible(child: rightWidget()),
          ],
        ),
      ),
    );
  }

  Row rightWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(child: SizedBox(width: 300, child: searchTextField())),
        const SizedBox(width: 16),
        loginButton(),
      ],
    );
  }

  Row leftWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoButton(),
        const SizedBox(width: 10),
        categoryButton(),
        const SizedBox(width: 20),
        faqButton(),
        const SizedBox(width: 20),
        nameTuneButton(),
      ],
    );
  }

  GenericButton faqButton() {
    return GenericButton(
      title: faqStr,
      padding: EdgeInsets.zero,
      bgColor: transparent,
      height: double.infinity,
      onTap: () {
        print("check ");
      },
    );
  }

  GenericButton nameTuneButton() {
    return GenericButton(
      title: nameTuneStr,
      padding: EdgeInsets.zero,
      bgColor: transparent,
      height: double.infinity,
      onTap: () {
        print("check ");
      },
    );
  }

  GenericButton logoButton() {
    return GenericButton(
      padding: EdgeInsets.zero,
      bgColor: transparent,
      height: double.infinity,
      leadingIcon: SizedBox(width: 70, child: Image.asset(logoImage)),
      onTap: () {
        print("check ");
      },
    );
  }

  Widget loginButton() {
    return GenericButton(
      bgColor: white,
      leadingIcon: const Padding(
        padding: EdgeInsets.only(right: 4),
        child: Icon(
          Icons.person,
          size: 18,
        ),
      ),
      title: loginStr,
      onTap: () {},
    );
  }

  Widget searchTextField() {
    return CustomSearchTextfield(
      controller: TextEditingController(),
      borderColor: white,
      onChange: (p0) {
        print("On change $p0");
      },
      onSubmit: (p0) {
        print("on submit $p0");
      },
    );
  }

  ResponsiveBuilder categoryButton() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return GenericButton(
          height: double.infinity,
          bgColor: transparent,
          title: tunesStr,
          trailingIcon: Padding(
            padding: const EdgeInsets.only(left: 4, top: 4.0),
            child: Image.asset(
              arrowDownPng,
              color: black,
              height: 7,
            ),
          ),
          onTap: () {
            categoryPopupView(context);
          },
        );
      },
    );
  }

  Future<void> categoryPopupView(BuildContext context) {
    return showPopover(
      arrowDyOffset: -10,
      context: context,
      backgroundColor: white,
      bodyBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: white,
            ),
            height: 180,
            child: ListView.builder(
              padding: const EdgeInsets.all(2),
              scrollDirection: Axis.horizontal,
              itemCount: appController
                  .categories.length, //StoreManager.categories?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: categoryCard(index));
              },
            ),
          ),
        );
      },
    );
  }

  Padding categoryCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: white,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            customImage(
                url: appController.categories[index].menuImagePath,
                gredientColor: gredientColor),
            CustomText(
              title: appController.categories[index].categoryName ?? '',
              color: white,
              fontName: FontName.bold,
            ),
          ],
        ),
      ),
    );
  }
}
