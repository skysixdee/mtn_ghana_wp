import 'package:etisalat/files/reusable_widgets/custom_scroll_view/aligned_grid.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GenericGridView extends StatelessWidget {
  const GenericGridView({
    super.key,
    required this.itemCount,
    required this.builder,
    this.onTap,
    this.onlyGrid = false,
    this.maxDisplay = 8,
    this.physics,
    this.cardHeight = 240,
    this.cardWidth = 200,
    this.padding,
    this.scrollDirection,
    this.childAspectRatio,
  });
  final double cardHeight;

  final double cardWidth;
  final int itemCount;
  final bool onlyGrid;
  final double? childAspectRatio;
  final Axis? scrollDirection;
  final EdgeInsetsGeometry? padding;
  final Widget Function(int) builder;
  final Function(int index)? onTap;
  final int maxDisplay;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return itemCount == 0
            ? (emptyListWidget(height: si.isMobile ? 100 : 200))
            : onlyGrid
                ? grid(si, context)
                : si.isMobile
                    ? grid(si, context)
                    : itemCount <= maxDisplay
                        ? Center(
                            child: alignedGrid(context, itemCount, cardWidth,
                                physics, builder, onTap))
                        : grid(si, context);
      },
    );
  }

  Widget grid(SizingInformation si, BuildContext contex) {
    return tuneGridView(itemCount, cardWidth, padding, builder: builder);
  }
}
