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
                        ? Center(child: alignedGrid(context))
                        : grid(si, context);
      },
    );
  }

  Widget grid(SizingInformation si, BuildContext contex) {
    return GridView.builder(
      scrollDirection: scrollDirection ?? Axis.vertical,
      padding: padding ??
          EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30, vertical: 20),
      itemCount: itemCount,
      physics: physics,
      shrinkWrap: true,
      gridDelegate: sliver(si, contex),
      itemBuilder: (context, index) {
        return (onTap != null)
            ? InkWell(onTap: onTap!(index), child: builder(index))
            : builder(index);
      },
    );
  }

  SliverGridDelegate sliver(SizingInformation si, BuildContext context) {
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: cardWidth + 40, //height,
      childAspectRatio: childAspectRatio ?? 0.7,
      mainAxisSpacing: si.isMobile ? 10 : 20,
      crossAxisSpacing: si.isMobile ? 10 : 20,
    );
  }

  Widget alignedGrid(BuildContext context) {
    const double runSpacing = 14;
    const double spacing = 14;
    int listCount = itemCount;
    double w = cardWidth;

    return SingleChildScrollView(
      physics: physics,
      child: Wrap(
        runSpacing: runSpacing,
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: List.generate(listCount, (index) {
          return SizedBox(
              width: w,
              child: AspectRatio(
                aspectRatio: 0.75,
                child: InkWell(
                  onTap: () {
                    if (onTap != null) {
                      onTap!(index);
                    }
                  },
                  child: builder(index),
                ),
              ));
        }),
      ),
    );
  }
}
