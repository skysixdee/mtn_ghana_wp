import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

class RemainderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomText(
              title: remainderBenfitsStr,
              fontName: FontName.bold,
              fontSize: 25,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomText(
                title: letYourCallersStr,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            height: 20,
          ),
          pauseGenericButton(),
          const SizedBox(
            height: 20,
          ),
          subscribeGenericButton(),
          const SizedBox(
            height: 20,
          ),
          bottomGenericButtons(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget pauseGenericButton() {
    return Center(
      child: const GenericButton(
        width: 50,
        leadingIcon: Icon(
          Icons.pause,
          color: pink,
        ),
        bgColor: white,
        borderColor: pink,
        radius: 2,
      ),
    );
  }
}

Widget subscribeGenericButton() {
  return Center(
    child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: pink,
          borderRadius: BorderRadius.circular(2),
        ),
        child: CustomText(
          title: subscribeStr,
          textAlign: TextAlign.center,
          color: white,
        )),
  );
}

Widget bottomGenericButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const GenericButton(
        leadingIcon: Icon(Icons.favorite),
        // trailingIcon: Text("favorite"),
        bgColor: white,
        borderColor: lightGrey,
        radius: 2,
      ),
      const SizedBox(
        width: 20,
      ),
      Container(
          padding: const EdgeInsets.all(8),
          child: const GenericButton(
            leadingIcon: Icon(Icons.person_add),
            //  trailingIcon: Text("tell a friend "),
            bgColor: white,
            borderColor: lightGrey,
            radius: 2,
          )),
      const SizedBox(width: 20),
      const GenericButton(
        leadingIcon: Icon(Icons.card_giftcard),
        // trailingIcon: Text("Gift"),
        bgColor: white,
        borderColor: lightGrey,
        radius: 2,
      ),
      const SizedBox(
        width: 20,
      ),
      const GenericButton(
        leadingIcon: Icon(Icons.settings),
        //trailingIcon: Text("settings"),
        bgColor: white,
        borderColor: lightGrey,
        radius: 2,
      ),
    ],
  );
}
