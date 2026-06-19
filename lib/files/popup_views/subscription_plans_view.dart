import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/subscription_plan_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/subscription_pack_list_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class SubscriptionPlansView extends StatefulWidget {
  const SubscriptionPlansView({super.key, required this.onConfirm});
  final Function(SubscriptionPackListModel item) onConfirm;
  @override
  State<SubscriptionPlansView> createState() => _SubscriptionPlansViewState();
}

class _SubscriptionPlansViewState extends State<SubscriptionPlansView> {
  late SubscriptionPlanController con;
  @override
  void initState() {
    con = Get.put(SubscriptionPlanController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SubscriptionPlanController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: popupWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerView(context),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  descriptionView(),
                  const SizedBox(height: 30),
                  subscriptionList(),
                  const SizedBox(height: 30),
                  bottomButtons(),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headerView(BuildContext context) {
    return Container(
      height: 50,
      color: lightGrey,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: chooseSubscriptionPlanStr,
              fontName: FontName.bold,
              fontSize: 14,
            ),
            GenericButton(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              bgColor: transparent,
              leadingIcon: const Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget descriptionView() {
    return CustomText(
      textAlign: TextAlign.center,
      title: youShouldSubscribeAPlanStr,
      color: grey,
      fontSize: 12,
    );
  }

  Widget subscriptionList() {
    return Center(
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: con.packList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: AspectRatio(aspectRatio: 1, child: packCard(index)),
            );
          },
        ),
      ),
    );
  }

  Widget packCard(int index) {
    return Obx(
      () {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: con.selectedIndex.value == index ? yellow : lightGrey,
          ),
          child: GenericButton(
            onTap: () {
              con.updateOnSelection(index);
            },
            bgColor: transparent,
            padding: const EdgeInsets.all(0),
            leadingIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  title: con.packList[index].price,
                  fontName: FontName.bold,
                  fontSize: 16,
                ),
                CustomText(
                  title: con.packList[index].value,
                  fontName: FontName.bold,
                  fontSize: 12,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomButtons() {
    return Row(
      children: [
        Expanded(
          child: GenericButton(
            borderColor: grey,
            bgColor: lightGrey,
            title: cancelStr,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: GenericButton(
            bgColor: yellow,
            title: confirmStr,
            onTap: () {
              widget.onConfirm(con.packList[con.selectedIndex.value]);
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
