import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';

import 'package:get/get.dart';

class ReserveStep1Bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressController());
    Get.lazyPut(() => VoucherController());
  }
}

class ReserveStep2Bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressController());
    Get.lazyPut(() => VoucherController());
    Get.lazyPut(() => CompanyController());
    Get.lazyPut(() => DateInfoController());
    Get.lazyPut(() => ServiceInfoController());
    Get.lazyPut(() => AdditionalFeeController());
  }
}
