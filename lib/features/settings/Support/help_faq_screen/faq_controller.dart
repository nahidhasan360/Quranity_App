import 'package:get/get.dart';

class HelpFaqController extends GetxController {
  // Observable expanded states for each FAQ
  final expanded1 = false.obs;
  final expanded2 = false.obs;
  final expanded3 = false.obs;
  final expanded4 = false.obs;
  final expanded5 = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Expand first item by default
    expanded1.value = true;
    print('❓ Help & FAQ initialized');
  }

  /// Toggle FAQ item
  void toggleFaq(int index) {
    switch (index) {
      case 1:
        expanded1.value = !expanded1.value;
        break;
      case 2:
        expanded2.value = !expanded2.value;
        break;
      case 3:
        expanded3.value = !expanded3.value;
        break;
      case 4:
        expanded4.value = !expanded4.value;
        break;
      case 5:
        expanded5.value = !expanded5.value;
        break;
    }
    print('❓ FAQ $index toggled: ${_isExpanded(index)}');
  }

  /// Check if FAQ is expanded
  bool _isExpanded(int index) {
    switch (index) {
      case 1:
        return expanded1.value;
      case 2:
        return expanded2.value;
      case 3:
        return expanded3.value;
      case 4:
        return expanded4.value;
      case 5:
        return expanded5.value;
      default:
        return false;
    }
  }
}