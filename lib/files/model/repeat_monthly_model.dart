import 'package:get/get.dart';

class RepeatMonthlyModel {
  String title = '';
  RxBool isSelected = false.obs;
  RepeatMonthlyModel(this.title, {bool isSelected = false}) {
    this.isSelected.value = isSelected;
  }
}
