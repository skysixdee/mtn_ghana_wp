import 'package:etisalat/files/reusable_widgets/empty_list_widget.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GenericScrollView extends StatelessWidget {
  GenericScrollView({
    super.key,
    required this.builder,
    required this.itemCount,
    this.cardHeight = 240,
    this.cardWidth = 200,
    this.onlyGrid = false,
    this.childAspectRatio,
    this.scrollDirection,
    this.padding,
    this.onTap,
    this.maxDisplay = 8,
    this.physics,
    this.sliverAppBarHeight = 0,
    this.sliverAppBar,
    this.sliverToBoxAdapter,
    this.pinnedAppBar = true,
    this.collapsedHeight = 68,
    this.isLoading = false,
  });
  final double cardHeight;
  final double? sliverAppBarHeight;
  final Widget? sliverAppBar;
  final Widget? sliverToBoxAdapter;
  final double cardWidth;
  final double? collapsedHeight;
  final int itemCount;
  final bool pinnedAppBar;
  final bool onlyGrid;
  final bool isLoading;
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
        return CustomScrollView(
          primary: isLoading ? false : true,
          physics: physics,
          slivers: (sliverAppBar != null)
              ? [
                  sliverToBoxAdapterBuilder(),
                  sliverAppBarBuilder(),
                  isLoading ? _loadingIndicator() : sliverGridBuilder(si),
                ]
              : [
                  sliverToBoxAdapterBuilder(),
                  isLoading ? _loadingIndicator() : sliverGridBuilder(si),
                ],
        );
      },
    );
  }

  SliverToBoxAdapter _loadingIndicator() {
    return SliverToBoxAdapter(
      child: loadingIndicator(height: 300),
    );
  }

  SliverToBoxAdapter _emptyMessage() {
    return SliverToBoxAdapter(
      child: SizedBox(height: 300, child: Center(child: emptyListWidget())),
    );
  }

  SliverAppBar sliverAppBarBuilder() {
    return SliverAppBar(
      collapsedHeight: collapsedHeight,
      pinned: pinnedAppBar,
      expandedHeight: (sliverAppBar != null) ? sliverAppBarHeight : 0,
      flexibleSpace: (sliverAppBar != null) ? sliverAppBar : const SizedBox(),
    );
  }

  SliverToBoxAdapter sliverToBoxAdapterBuilder() {
    return SliverToBoxAdapter(
      child:
          (sliverToBoxAdapter != null) ? sliverToBoxAdapter : const SizedBox(),
    );
  }

  Widget sliverGridBuilder(SizingInformation si) {
    return SliverPadding(
      padding: padding ??
          EdgeInsets.symmetric(
              horizontal: si.isMobile ? 8 : 25, vertical: si.isMobile ? 8 : 20),
      sliver: itemCount <= 0
          ? _emptyMessage()
          : SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: cardWidth + 40, //height,
                childAspectRatio: childAspectRatio ?? 0.7,
                mainAxisSpacing: si.isMobile ? 10 : 20,
                crossAxisSpacing: si.isMobile ? 10 : 20,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return (onTap != null)
                      ? InkWell(onTap: onTap!(index), child: builder(index))
                      : builder(index);
                },
                childCount: itemCount,
              ),
            ),
    );
  }
}
