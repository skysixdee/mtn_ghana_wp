import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialSharingPopup extends StatelessWidget {
  final TuneInfo info;
  SocialSharingPopup({super.key, required this.info});
  final List<String> socialIconList = [facebookPng, twitterPng];
  final List<String> socialNameList = [facebookStr, twitterStr];
  final List<String> socialLinkList = [
    "https://www.facebook.com/sharer.php?u=",
    "https://twitter.com/share?url="
  ];
  //&text=shiveterteret
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            height: 200,
            child: listContainerView(context),
          ),
        ),
      ),
    );
  }

  Widget headerView(BuildContext context) {
    return Container(
      height: 40,
      color: lightGrey,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: shareOnStr,
              fontName: FontName.bold,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close),
                ))
          ],
        ),
      ),
    );
  }

  Widget listContainerView(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Center(
        child: Column(
          children: [
            headerView(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: socialIconList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Center(
                        child: listCard(context, index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        print("tone is = ${info.toneId}");
        print("toneName is = ${info.toneName}");

        print("artistName is = ${info.artistName}");

        final fullUrl = Uri.base.toString();

        final uri = Uri.parse(fullUrl);

        final basePath =
            '${uri.scheme}://${uri.host}${uri.pathSegments.isNotEmpty ? '/${uri.pathSegments.first}' : ''}/';

        print(basePath);
        //socialLinkList
        if (index == 1) {
          String predefinedText = 'share predefined text'.tr;
          _launchUrl(
              "${socialLinkList[index]}$basePath+search?search=${info.toneId}&index=2&text=$predefinedText");
        } else {
          _launchUrl(
              "${socialLinkList[index]}$basePath+search?search=${info.toneId}&index=2");
        }

        // Share.share('check out my website https://example.com',
        //     subject: 'Look what I made!');
        Navigator.of(context).pop();
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(socialIconList[index]),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    print("urls ======= ${url}");
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
