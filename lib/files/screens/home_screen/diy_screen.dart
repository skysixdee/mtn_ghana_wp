import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_textfield.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';

class DiyScreen extends StatelessWidget {
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
                  title: doItYourselfStr,
                  textAlign: TextAlign.center,
                  fontSize: 25,
                  fontName: FontName.bold,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomText(
                title: shareYourSongStr,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            myTuneSearchField(),
            const SizedBox(
              height: 20,
            ),
            audioSearchField(),
            const SizedBox(
              height: 20,
            ),
            submitButton(),
          ],
        ));
  }

  Widget myTuneSearchField() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: CustomText(
                title: nameOfTuneStr,
                fontSize: 12,
                color: grey,
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 40, top: 10, bottom: 10),
              child: CustomTextfield(
                width: 250,
                trailingChild: SizedBox(),
                controller: TextEditingController(text: " "),
              )),
        ],
      ),
    );
  }

  Widget audioSearchField() {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(9),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fileNameStr,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                replaceStr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Center(
      child: GenericButton(
        width: 100,
        title: submitStr,
        bgColor: yellow,
        textColor: white,
      ),
    );
  }
}
