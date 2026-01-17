
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'account-controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy load controller - only created when needed
    Get.lazyPut<AccountController>(
          () => AccountController(),
      fenix: true, // Keeps controller alive for back navigation
    );

    // Alternative: Use Get.put() for immediate initialization
    // Get.put<AccountController>(AccountController());

    print('✅ AccountBinding: Controller registered');
  }
}