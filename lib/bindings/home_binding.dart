import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/calculator_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';

import 'package:app/controllers/review_controller.dart';

import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => ManagerController());
    Get.lazyPut(() => ReviewController());
    Get.lazyPut(() => AddressController());
    Get.lazyPut(() => MypageController());
    Get.lazyPut(() => ServiceInfoController());
    Get.lazyPut(() => DateInfoController());
  }
}
