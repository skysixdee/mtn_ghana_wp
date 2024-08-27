import 'package:etisalat/files/reusable_widgets/custom_scroll_view/aligned_grid.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';

Widget alignGridCombineView({
  required BuildContext context,
  required int listCount,
  required double cardWidth,
  required EdgeInsetsGeometry? padding,
  Axis? scrollDirection,
  bool isLoading = false,
  ScrollPhysics? physics,
  required Widget Function(int) builder,
  required dynamic Function(int)? onTap,
  double aspectRatio = 0.7,
}) {
  return listCount < 8
      ? alignedGrid(context, listCount, cardWidth, physics, builder, onTap,
          isLoading: isLoading, aspectRatio: aspectRatio)
      : tuneGridView(
          itemCount: listCount,
          padding: padding,
          cardWidth: cardWidth,
          scrollDirection: scrollDirection,
          isLoading: isLoading,
          physics: physics,
          aspectRatio: aspectRatio,
          builder: builder,
          onTap: onTap);
}
