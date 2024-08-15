import 'package:cached_network_image/cached_network_image.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

Widget customImage(
    {String? url, Color gredientColor = transparent, double cornerRadius = 0}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: CachedNetworkImage(
          imageUrl: url ?? '',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter:
                      const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
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
