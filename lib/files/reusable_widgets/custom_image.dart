import 'package:cached_network_image/cached_network_image.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';

Widget customImage(
    {String? url,
    String? imageName,
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
        child: imageName != null
            ? Center(
                child: Image.asset(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  imageName,
                  fit: BoxFit.fill,
                ),
              )
            : CachedNetworkImage(
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
                    child: Image.asset(defaultImagePng,
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity)
                    //     CustomText(
                    //   title: title,
                    //   fontName: FontName.bold,
                    //   fontSize: 20,
                    // )
                    ),
              ),
      ),
      Container(color: gredientColor)
    ],
  );
}
