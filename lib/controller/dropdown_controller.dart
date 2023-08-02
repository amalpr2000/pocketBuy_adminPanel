import 'package:get/get.dart';

class DropdownController extends GetxController {
  DropdownController({required this.item, required this.value});
  final List<String> item;
  String value;

  selectItem(String selectedValue) {
    value = selectedValue;
    update();
  }
}
