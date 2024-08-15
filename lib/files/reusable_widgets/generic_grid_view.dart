import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GenericGridView extends StatelessWidget {
  const GenericGridView({
    super.key,
    required this.itemCount,
    required this.builder,
    this.onTap,
    this.maxDisplay = 8,
    this.physics,
  });
  final int itemCount;
  final Widget Function(int) builder;
  final Function(int index)? onTap;
  final int maxDisplay;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? grid(si)
            : itemCount <= maxDisplay
                ? Center(child: alignedGrid(context))
                : grid(si);
      },
    );
  }

  Widget grid(SizingInformation si) {
    return GridView.builder(
      padding:
          EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30, vertical: 20),
      itemCount: itemCount,
      physics: physics,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              if (onTap != null) {
                onTap!(index);
              }
            },
            child: builder(index));
      },
    );
  }

  Widget alignedGrid(BuildContext context) {
    const double runSpacing = 14;
    const double spacing = 14;
    int listCount = itemCount;
    double w = 220;
    double h = 240;

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
