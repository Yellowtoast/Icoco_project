import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/signup_controller.dart';

import 'package:get/get.dart';

class SignupBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
