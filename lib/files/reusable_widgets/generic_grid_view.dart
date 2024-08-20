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
    this.cardWidth = 220,
    this.padding,
    this.scrollDirection,
  });
  final double cardHeight;

  final double cardWidth;
  final int itemCount;
  final bool onlyGrid;
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
            ? (emptyListWidget())
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
    // double cellCount = MediaQuery.of(context).size.width / 250;
    // return SliverGridDelegateWithFixedCrossAxisCount(
    //     mainAxisExtent: 250, crossAxisCount: cellCount.toInt());
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: cardWidth, //height,
      mainAxisExtent: cardHeight, //width,
      mainAxisSpacing: si.isMobile ? 10 : 20,
      crossAxisSpacing: si.isMobile ? 10 : 20,
    );
  }

  Widget alignedGrid(BuildContext context) {
    const double runSpacing = 14;
    const double spacing = 14;
    int listCount = itemCount;
    double w = cardWidth;
    double h = cardHeight;

    return SingleChildScrollView(
      physics: physics,
      child: Wrap(
        runSpacing: runSpacing,
        spacing: spacing,
        alignment: WrapAlignment.center,
        children: List.generate(listCount, (index) {
          return SizedBox(
              height: h,
              width: w,
              child: InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap!(index);
                  }
                },
                child: builder(index),
              ));
        }),
      ),
    );
  }
}
