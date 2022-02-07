import 'package:app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoadingBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
