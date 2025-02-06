import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/faq_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/faq_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FaqScreen extends StatelessWidget {
  final FaqController faqController = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: si.isMobile ? 8 : 20, vertical: 20),
          child: ListView(
            children: [
              Center(
                child: CustomText(
                  title: faqCStr,
                  color: black,
                  fontSize: si.isMobile ? 30 : 55,
                ),
              ),
              Center(
                child: CustomText(
                  title: howCanIHelpYouStr,
                  color: grey,
                  fontSize: si.isMobile ? 16 : 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                if (faqController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (faqController.hasError.value) {
                  return Center(
                      child: CustomText(
                    title: faqFailerStr,
                  ));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: faqController.faqData.value.faqList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return FaqItem(index: index);
                    },
                  );
                }
              }),
            ],
          ),
        );
      },
    );
  }
}

class FaqItem extends StatelessWidget {
  final int index;
  final FaqController faqController = Get.find<FaqController>();

  FaqItem({required this.index});

  @override
  Widget build(BuildContext context) {
    final faqItem = faqController.faqData.value.faqList![index];
    return ResponsiveBuilder(
      builder: (context, si) {
        return cards(faqItem, si);
      },
    );
  }

  Obx cards(FaqList faqItem, SizingInformation si) {
    return Obx(() {
      return Card(
        elevation: 0,
        color: white,
        margin:
            EdgeInsets.symmetric(vertical: 8, horizontal: si.isMobile ? 2 : 16),
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(
                  //   faqController.isExpanded[index] == true
                  //       ? Icons.play_arrow_outlined
                  //       : Icons.play_arrow,
                  // ),
                  SizedBox(width: 4),
                  Expanded(
                      child: Text(
                    faqItem.question ?? '',
                    style: TextStyle(
                        fontFamily: FontName.regular.name,
                        fontWeight: FontWeight.bold,
                        fontSize: si.isMobile ? 13 : 18),
                  )),
                  Icon(
                    faqController.isExpanded[index] == true
                        ? Icons.remove
                        : Icons.add,
                    size: si.isMobile ? 18 : 22,
                  ),
                ],
              ),
              onTap: () {
                faqController.toggleExpansion(index);
              },
            ),
            if (faqController.isExpanded[index] == true)
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: faqItem.answer!.expand((answer) {
                    return [
                      if (answer.header != null && answer.header!.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: answer.header!,
                            fontSize: 15,
                          ),
                        ),
                      Padding(
                        padding:
                            answer.header != null && answer.header!.isNotEmpty
                                ? const EdgeInsets.only(left: 25, bottom: 25)
                                : const EdgeInsets.only(left: 0, bottom: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: answer.dataList!.map((dataList) {
                            List<TextSpan> combinedTextSpans =
                                dataList.data!.map((datum) {
                              return TextSpan(
                                text: datum.text ?? '',
                                style: TextStyle(
                                  fontFamily: datum.style?.fontStyle == 'italic'
                                      ? FontName.regular.name
                                      : FontName.regular.name,
                                  fontWeight: datum.style?.fontWeight == 900
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  decoration:
                                      datum.style?.textDecoration == 'underline'
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: si.isMobile ? 14 : 16,
                                ),
                              );
                            }).toList();
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '• ',
                                        style: TextStyle(

                                            //  fontFamily: FontName.bold.name,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: si.isMobile ? 15 : 20),
                                      ),
                                      TextSpan(
                                        children: combinedTextSpans,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ];
                  }).toList(),
                ),
              )
          ],
        ),
      );
    });
  }
}
