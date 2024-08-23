import 'package:cached_network_image/cached_network_image.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

Widget customImage(
    {String? url,
    Color gredientColor = transparent,
    double cornerRadius = 0,
    BoxFit? fit}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: CachedNetworkImage(
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
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      ),
      Container(color: gredientColor)
    ],
  );
}
