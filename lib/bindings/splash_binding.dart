import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/fcm_controller.dart';
import 'package:app/controllers/home_controller.dart';

import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(FCMController());
  }
}
