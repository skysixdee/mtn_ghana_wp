import 'package:etisalat/files/screens/my_tune_screen/header_view/my_tune_header_view.dart';
import 'package:etisalat/files/screens/my_tune_screen/my_music_box_view/my_music_box_view.dart';
import 'package:etisalat/files/screens/my_tune_screen/my_tune_view/my_tune_view.dart';
import 'package:etisalat/files/screens/my_tune_screen/playing_tune_view/playing_tune_view.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:flutter/material.dart';

class MyTuneScreen extends StatelessWidget {
  const MyTuneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        const MyTuneHeaderView(),
        const SizedBox(height: 20),
        PlayingTuneView(),
        const SizedBox(height: 20),
        MyTuneView(),
        const SizedBox(height: 20),
        MyMusicBoxView()
      ],
    );
  }
}
