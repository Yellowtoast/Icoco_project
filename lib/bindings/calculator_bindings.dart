import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/calculator_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/controllers/voucher_controller.dart';

import 'package:app/controllers/review_controller.dart';

import 'package:get/get.dart';

class CalculatorBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculatorController());
    Get.lazyPut(() => AddressController());
    Get.lazyPut(() => VoucherController());
  }
}
