import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/controllers/additional_fee_controller.dart';
import 'package:app/controllers/date_info_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/service_info_controller.dart';

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
    Get.lazyPut(() => CompanyController());
    Get.lazyPut(() => VoucherController());
    Get.lazyPut(() => ServiceInfoController());
    Get.lazyPut(() => AdditionalFeeController());
  }
}
