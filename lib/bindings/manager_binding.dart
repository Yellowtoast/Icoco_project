import 'package:app/controllers/manager_controller.dart';

import 'package:get/get.dart';

class ManagerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagerController());
  }
}
