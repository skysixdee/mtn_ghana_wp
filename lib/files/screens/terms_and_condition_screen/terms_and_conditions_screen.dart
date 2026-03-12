import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/terms_and_conditions_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/terms_and_conditions_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final TermsAndConditionsController termsController =
      Get.put(TermsAndConditionsController());

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
                  title: termsAndConditionsStr,
                  color: black,
                  fontSize: si.isMobile ? 30 : 55,
                ),
              ),
              Center(
                child: CustomText(
                  title: pleaseReadFollwingStr,
                  color: grey,
                  fontSize: si.isMobile ? 16 : 20,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (termsController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (termsController.hasError.value) {
                  return Center(
                      child:
                          CustomText(title: failedToLoadTermsAndConditionsStr));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: termsController
                            .termsData.value.termsconditionsList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return termsItemWidget(index);
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

Widget termsItemWidget(int index) {
  final TermsAndConditionsController termsController =
      Get.find<TermsAndConditionsController>();
  final termsItem = termsController.termsData.value.termsconditionsList![index];

  return ResponsiveBuilder(
    builder: (context, si) {
      return Obx(() {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: grey, // your color
              width: 1,
            ),
          ),
          color: isDarkTheme(context) ? blackD : white,
          margin: EdgeInsets.symmetric(
              vertical: 8, horizontal: si.isMobile ? 2 : 16),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        termsItem.question ?? '',
                        style: TextStyle(
                            fontFamily: FontName.regular.name,
                            fontWeight: FontWeight.bold,
                            fontSize: si.isMobile ? 13 : 18,
                            color: isDarkTheme(context) ? whiteD : black),
                      ),
                    ),
                    Icon(
                      termsController.isExpanded[index] == true
                          ? Icons.remove
                          : Icons.add,
                      size: si.isMobile ? 18 : 22,
                    ),
                  ],
                ),
                onTap: () {
                  termsController.toggleExpansion(index);
                },
              ),
              if (termsController.isExpanded[index] == true)
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: termsItem.answer!.expand((answer) {
                      return [
                        if (answer.header != null && answer.header!.isNotEmpty)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                title: answer.header!,
                                fontSize: 15,
                                color: isDarkTheme(context) ? whiteD : black),
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
                                    fontFamily:
                                        datum.style?.fontStyle == 'italic'
                                            ? FontName.regular.name
                                            : FontName.regular.name,
                                    fontWeight: datum.style?.fontWeight == 900
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    decoration: datum.style?.textDecoration ==
                                            'underline'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    color:
                                        isDarkTheme(context) ? whiteD : black,
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
                                            fontWeight: FontWeight.bold,
                                            color: isDarkTheme(context)
                                                ? whiteD
                                                : black,
                                            fontSize: si.isMobile ? 15 : 20,
                                          ),
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
    },
  );
}








// class TermsAndConditionsScreen extends StatelessWidget {
//   final TermsAndConditionsController termsController = Get.put(TermsAndConditionsController());

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//       builder: (context, si) {
//         return Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: si.isMobile ? 8 : 20, vertical: 20),
//           child: ListView(
//             children: [
//               Center(
//                 child: CustomText(
//                   title: "Terms & Conditions",
//                   color: black,
//                   fontSize: si.isMobile ? 30 : 55,
//                 ),
//               ),
//               Center(
//                 child: CustomText(
//                   title: "Please read the following terms carefully.",
//                   color: grey,
//                   fontSize: si.isMobile ? 16 : 20,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Obx(() {
//                 if (termsController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (termsController.hasError.value) {
//                   return Center(child: CustomText(title: "Failed to load terms & conditions"));
//                 } else {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: termsController.termsData.value.termsconditionsList?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       return TermsItem(index: index);
//                     },
//                   );
//                 }
//               }),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class TermsItem extends StatelessWidget {
//   final int index;
//   final TermsAndConditionsController termsController = Get.find<TermsAndConditionsController>();

//   TermsItem({required this.index});

//   @override
//   Widget build(BuildContext context) {
//     final termsItem = termsController.termsData.value.termsconditionsList![index];
//     return ResponsiveBuilder(
//       builder: (context, si) {
//         return cards(termsItem, si);
//       },
//     );
//   }

//   Obx cards(TermsconditionsList termsItem, SizingInformation si) {
//     return Obx(() {
//       return Card(
//         elevation: 0,
//         color: white,
//         margin: EdgeInsets.symmetric(vertical: 8, horizontal: si.isMobile ? 2 : 16),
//         child: Column(
//           children: [
//             ListTile(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(width: 4),
//                   Expanded(
//                     child: Text(
//                       termsItem.question ?? '',
//                       style: TextStyle(
//                         fontFamily: FontName.regular.name,
//                         fontWeight: FontWeight.bold,
//                         fontSize: si.isMobile ? 13 : 18,
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     termsController.isExpanded[index] == true ? Icons.remove : Icons.add,
//                     size: si.isMobile ? 18 : 22,
//                   ),
//                 ],
//               ),
//               onTap: () {
//                 termsController.toggleExpansion(index);
//               },
//             ),
//             if (termsController.isExpanded[index] == true)
//               Padding(
//                 padding: const EdgeInsets.only(left: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: termsItem.answer!.expand((answer) {
//                     return [
//                       if (answer.header != null && answer.header!.isNotEmpty)
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: CustomText(
//                             title: answer.header!,
//                             fontSize: 15,
//                           ),
//                         ),
//                       Padding(
//                         padding: answer.header != null && answer.header!.isNotEmpty
//                             ? const EdgeInsets.only(left: 25, bottom: 25)
//                             : const EdgeInsets.only(left: 0, bottom: 25),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: answer.dataList!.map((dataList) {
//                             List<TextSpan> combinedTextSpans = dataList.data!.map((datum) {
//                               return TextSpan(
//                                 text: datum.text ?? '',
//                                 style: TextStyle(
//                                   fontFamily: datum.style?.fontStyle == 'italic'
//                                       ? FontName.regular.name
//                                       : FontName.regular.name,
//                                   fontWeight: datum.style?.fontWeight == 900
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                   decoration: datum.style?.textDecoration == 'underline'
//                                       ? TextDecoration.underline
//                                       : TextDecoration.none,
//                                   color: Colors.black,
//                                   fontSize: si.isMobile ? 14 : 16,
//                                 ),
//                               );
//                             }).toList();
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 5),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: '• ',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: si.isMobile ? 15 : 20,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         children: combinedTextSpans,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ];
//                   }).toList(),
//                 ),
//               )
//           ],
//         ),
//       );
//     });
//   }
// }


