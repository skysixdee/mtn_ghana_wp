import 'package:get/get.dart';

class RepeatDayModel {
  String titleFull;
  String titleSort;
  RxBool isSelected = false.obs;
  RepeatDayModel(this.titleFull, this.titleSort);
}
