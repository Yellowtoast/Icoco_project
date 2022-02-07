import 'package:app/bindings/manager_detail_binding.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/review_controller.dart';

import 'package:get/get.dart';

class ReviewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewController());
    Get.put(ManagerBindings());
  }
}
