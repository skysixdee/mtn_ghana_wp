import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget alignedGrid(BuildContext context, int listCount, double cardWidth,
    ScrollPhysics? physics, Widget Function(int) builder, Function(int)? onTap,
    {double aspectRatio = 0.7, bool isLoading = false}) {
  const double runSpacing = 14;
  const double spacing = 14;
  //int listCount = itemCount;
  //double w = cardWidth;

  return SingleChildScrollView(
    physics: physics,
    child: isLoading
        ? loadingIndicator(height: 300)
        : Wrap(
            runSpacing: runSpacing,
            spacing: spacing,
            alignment: WrapAlignment.center,
            children: List.generate(listCount, (index) {
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
          ),
  );
}
