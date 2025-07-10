import 'package:flutter/widgets.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';

Widget buyMusicBoxButton() {
  return GenericButton(
    title: "Buy music box",
    onTap: () {
      print("tapped");
    },
  );
}
