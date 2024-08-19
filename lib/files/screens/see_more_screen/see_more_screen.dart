import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:flutter/material.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({super.key, required this.list});
  final List<TuneInfo> list;
  @override
  Widget build(BuildContext context) {
    return GenericGridView(
      itemCount: list.length,
      builder: (index) {
        return TuneCard(info: list[index]);
      },
    );
  }
}
