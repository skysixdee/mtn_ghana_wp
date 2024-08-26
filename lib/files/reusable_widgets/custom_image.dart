import 'package:cached_network_image/cached_network_image.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

Widget customImage(
    {String? url,
    Color gredientColor = transparent,
    double cornerRadius = 0,
    BoxFit? fit,
    String toneName = ""}) {
  String title = '';
  if (toneName.isNotEmpty) {
    List<String> ls = toneName.split(" ");
    for (var i = 0; i < ls.length; i++) {
      if (i < 2) {
        title += ls[i][0];
      }
    }
  }

  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: CachedNetworkImage(
          //imageUrl: 'https://picsum.photos/id/70/300/100',
          imageUrl: url ?? '',
          fit: fit ?? BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(
              child: CustomText(
            title: title,
            fontName: FontName.bold,
            fontSize: 20,
          )),
        ),
      ),
      Container(color: gredientColor)
    ],
  );
}
