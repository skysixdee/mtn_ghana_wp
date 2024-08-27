import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// this.cardHeight = 240,
//     this.cardWidth = 200,
Widget tuneGridView({
  required int itemCount,
  EdgeInsetsGeometry? padding,
  double? cardWidth,
  Axis? scrollDirection,
  bool isLoading = false,
  ScrollPhysics? physics,
  double aspectRatio = 0.7,
  required Widget Function(int) builder,
  Function(int)? onTap,
}) {
  return ResponsiveBuilder(
    builder: (context, si) {
      return isLoading
          ? loadingIndicator(height: 300)
          : GridView.builder(
              scrollDirection: scrollDirection ?? Axis.vertical,
              padding: padding ??
                  EdgeInsets.symmetric(
                      horizontal: si.isMobile ? 8 : 30, vertical: 20),
              itemCount: itemCount,
              physics: physics,
              shrinkWrap: true,
              gridDelegate: _sliver(si, context, cardWidth, aspectRatio),
              itemBuilder: (context, index) {
                return (onTap != null)
                    ? InkWell(onTap: () => onTap(index), child: builder(index))
                    : builder(index);
              },
            );
    },
  );
}

SliverGridDelegate _sliver(SizingInformation si, BuildContext context,
    double? cardWidth, double? childAspectRatio) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: (cardWidth ?? 200) + 40, //height,
    childAspectRatio: childAspectRatio ?? 0.7,
    mainAxisSpacing: si.isMobile ? 10 : 20,
    crossAxisSpacing: si.isMobile ? 10 : 20,
  );
}
