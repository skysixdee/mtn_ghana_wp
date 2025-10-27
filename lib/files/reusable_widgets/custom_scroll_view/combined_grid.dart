import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/aligned_grid.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CombinedGrid extends StatelessWidget {
  const CombinedGrid({
    super.key,
    required this.itemCount,
    this.cardWidth = 220,
    this.padding,
    this.scrollDirection,
    this.physics,
    required this.builder,
    this.onTap,
    this.isLoading = false,
    this.aspectRatio = 0.7,
  });
  final bool isLoading;
  final int itemCount;
  final double cardWidth;
  final EdgeInsetsGeometry? padding;
  final Axis? scrollDirection;

  final ScrollPhysics? physics;
  final Widget Function(int) builder;
  final dynamic Function(int)? onTap;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? tuneGridView(
                itemCount: itemCount,
                padding: padding,
                cardWidth: cardWidth,
                scrollDirection: scrollDirection,
                isLoading: isLoading,
                physics: physics,
                aspectRatio: aspectRatio,
                builder: builder,
                onTap: onTap)
            : itemCount < 8
                ? alignedGrid(
                    itemCount: itemCount,
                    cardWidth: cardWidth,
                    physics: physics,
                    builder: builder,
                    onTap: onTap,
                    isLoading: isLoading,
                    aspectRatio: aspectRatio)
                : tuneGridView(
                    itemCount: itemCount,
                    padding: padding,
                    cardWidth: cardWidth,
                    scrollDirection: scrollDirection,
                    isLoading: isLoading,
                    physics: physics,
                    aspectRatio: aspectRatio,
                    builder: builder,
                    onTap: onTap);
      },
    );
  }
}
