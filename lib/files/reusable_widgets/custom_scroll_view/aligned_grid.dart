import 'package:mtn_ghana_wp/files/reusable_widgets/empty_list_widget.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget alignedGrid(
    {double cardWidth = 180,
    double aspectRatio = 0.7,
    required int itemCount,
    ScrollPhysics? physics,
    required Widget Function(int) builder,
    Function(int)? onTap,
    bool isLoading = false}) {
  const double runSpacing = 14;
  const double spacing = 14;
  //int listCount = itemCount;
  //double w = cardWidth;

  return SingleChildScrollView(
      physics: physics,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return isLoading
              ? loadingIndicator(height: 300)
              : itemCount <= 0
                  ? SizedBox(height: 300, child: emptyListWidget())
                  : Wrap(
                      runSpacing: si.isMobile ? 8 : runSpacing,
                      spacing: si.isMobile ? 8 : spacing,
                      alignment: WrapAlignment.center,
                      children: List.generate(itemCount, (index) {
                        return SizedBox(
                            width: cardWidth,
                            child: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: (onTap != null)
                                  ? InkWell(
                                      onTap: () {
                                        onTap(index);
                                      },
                                      child: builder(index),
                                    )
                                  : builder(index),
                            ));
                      }),
                    );
        },
      ));
}
