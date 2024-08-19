import 'package:etisalat/files/controllers/my_tune_controllers/my_music_box_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_tune_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class TuneController {
  MyTuneController myTuneController = Get.find();
  MyMusicBoxController boxController = Get.find();
  MyPlayingTuneController playingTuneController = Get.find();

  makeApiCall() {
    myTuneController.getMyTune();
    // boxController.getMyMusicBoxTune();
    // playingTuneController.getPlayingTune();
  }
}
