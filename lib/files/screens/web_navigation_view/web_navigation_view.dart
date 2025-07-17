import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_tone_price_api.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/auth_controller/login_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/blacklist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/category_detail_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_wishlist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/name_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/profile_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/get_tone_price_model.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_textfield.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';

import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:mtn_ghana_wp/files/screens/authentication_screen/login_popup.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebNavigationView extends StatelessWidget {
  WebNavigationView({super.key});
  final AppController appController = Get.find();
  TextEditingController textEditingController = TextEditingController();
  List<PopoverMenuModel> myAccountMenuList = [
    PopoverMenuModel(myProfileStr),
    PopoverMenuModel(myTunezStr),
    PopoverMenuModel(myWishlistStr),
    //PopoverMenuModel(blackListStr),
    PopoverMenuModel(logoutStr)
  ];
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return (si.isMobile)
            ? const SizedBox()
            : Container(
                height: 70,
                color: yellow,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: leftWidget(context)),
                      Flexible(child: rightWidget(context)),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Row rightWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Flexible(child: SizedBox(width: 300, child: searchTextField(context))),
        // const SizedBox(width: 16),
        loginButton(),
      ],
    );
  }

  Row leftWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoButton(context),
        const SizedBox(width: 10),
        categoryButton(),
        const SizedBox(width: 20),
        faqButton(context),
        // const SizedBox(width: 20),
        // nameTuneButton(context),
      ],
    );
  }

  GenericButton faqButton(BuildContext context) {
    return GenericButton(
      title: faqStr,
      padding: EdgeInsets.zero,
      bgColor: transparent,
      height: double.infinity,
      onTap: () {
        customPrint("check FAQQQQ");
        context.goNamed(faqRoute);
      },
    );
  }

  GenericButton nameTuneButton(BuildContext context) {
    NameTuneController con = Get.find();
    return GenericButton(
      title: nameTuneStr,
      padding: EdgeInsets.zero,
      bgColor: transparent,
      height: double.infinity,
      onTap: () {
        con.getNameTune();
        context.goNamed(nameTuneRoute);
        customPrint("check ");
      },
    );
  }

  GenericButton logoButton(BuildContext context) {
    return GenericButton(
      padding: EdgeInsets.zero,
      bgColor: transparent,
      height: double.infinity,
      leadingIcon: SizedBox(width: 70, child: Image.asset(logoImage)),
      onTap: () {
        context.goNamed(homeRoute);
        customPrint("check ");
      },
    );
  }

  Widget loginButton() {
    LoginController con = Get.find();
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return GenericButton(
              bgColor: white,
              leadingIcon: const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.person,
                  size: 18,
                ),
              ),
              title: appCont.isLoggedIn.value ? myAccountStr : loginStr,
              onTap: () {
                if (StoreManager.isLoggedIn) {
                  myAccountMenu(context);
                } else {
                  con.resetValue();
                  Get.dialog(Obx(
                    () {
                      return con.displayOptScreen.value
                          ? LoginOtpPopup(
                              securityToken: con.securityToken,
                              isNewUser: con.isNewUser,
                              msisdn: con.msisdn,
                              isMusicBox: false,
                            )
                          : const LoginPopup();
                    },
                  ));
                }
              },
            );
          },
        );
      },
    );
  }

  Widget searchTextField(BuildContext context) {
    TuneSearchController con = Get.find();
    textEditingController.text = con.searchedText;
    return CustomTextfield(
      addSearchIcon: true,
      hintColor: white,
      controller: textEditingController,
      borderColor: white,
      onChange: (p0) {
        con.searchedText = p0;
        customPrint("On change $p0");
      },
      onSubmit: (p0) {
        con.searchedText = p0;
        con.getSongSearchResult(p0);
        context.goNamed(searchRoute,
            queryParameters: {'search': p0}); //goNamed(searchRoute);
        customPrint("on submit $p0");
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

  Future<void> myAccountMenu(BuildContext context) {
    return genericPopover(
      context,
      width: 150,
      myAccountMenuList,
      onTap: (model, index) {
        if (model.title == myWishlistStr) {
          MyWishlistController con = Get.find();
          con.getWishlist();
          context.goNamed(myWishlistRoute);
        } else if (model.title == myProfileStr) {
          ProfileController con = Get.find();
          con.getProfileDetail();
          context.goNamed(profileRoute);
        } else if (model.title == myTunezStr) {
          // MyTuneController con = Get.find();
          // con.getMyTune();
          TuneController cont = Get.find();
          cont.makeApiCall();
          context.goNamed(myTunesRoute);
        } else if (model.title == blackListStr) {
          BlacklistController bCont = Get.find();
          bCont.getList();
          context.goNamed(blackListRoute);
        } else if (model.title == logoutStr) {
          StoreManager.logout();
        }
      },
    );
  }

  Future<void> categoryPopupView(BuildContext context) {
    CategoryDetailController con = Get.find();
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
            width: 210,
            child: ListView.builder(
              padding: const EdgeInsets.all(2),
              scrollDirection: Axis.vertical,
              itemCount: appController
                  .categories.length, //StoreManager.categories?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      String catId =
                          appController.categories[index].categoryId ?? '';

                      context.goNamed(categoryDetailRoute,
                          queryParameters: {'catId': catId});
                      con.getCategoryDetailList(catId);
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
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 80,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: white,
        ),
        child: Stack(
          children: [
            customImage(
                url: appController.categories[index].menuImage,
                gredientColor: gredientColor),
            //     CustomText(
            //       title: appController.categories[index].categoryName ?? '',
            //       color: white,
            //       fontName: FontName.bold,
            //     ),
          ],
        ),
        // Column(
        //   //alignment: Alignment.center,
        //   children: [
        //     customImage(
        //         url: appController.categories[index].menuImagePath,
        //         gredientColor: gredientColor),
        //     CustomText(
        //       title: appController.categories[index].categoryName ?? '',
        //       color: white,
        //       fontName: FontName.bold,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
