import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation_controller.dart';
import 'package:app/controllers/review_controller.dart';

import 'package:get/get.dart';

class HomeSkeletonBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ReservationController());
  }
}
