import 'package:etisalat/files/model/navigation_header_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/get_navigation_view.dart';
import 'package:etisalat/files/reusable_widgets/navigation_header_view.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({super.key, required this.list, required this.name});
  final List<TuneInfo> list;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          getNavigationView(name),
          Expanded(
            child: GenericGridView(
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
  }
}
