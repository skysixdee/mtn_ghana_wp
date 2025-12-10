import 'package:mtn_ghana_wp/files/model/navigation_header_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({super.key, required this.list, required this.name});
  final List<TuneInfo> list;
  final String name;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: white,
          child: Column(
            children: [
              getNavigationView(name),
              Expanded(
                child: GenericScrollView(
                  onlyGrid: si.isMobile ? true : false,
                  itemCount: list.length,
                  builder: (index) {
                    return TuneCard(
                      info: list[index],
                      tuneList: list,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
