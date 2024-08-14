import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FeatureGridView extends StatelessWidget {
  const FeatureGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemBuilder: (context, index) {
        return Container(
          color: yellow,
        );
      },
    );
  }
}
