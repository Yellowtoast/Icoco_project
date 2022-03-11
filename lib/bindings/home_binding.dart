import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/calculator_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/event_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/mypage_controller.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/controllers/voucher_controller.dart';

import 'package:app/controllers/review_controller.dart';

import 'package:get/get.dart';

import '../controllers/date_info_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ManagerController());
    Get.put(MypageController());
    Get.put(VoucherController());
    Get.put(CompanyController());
    Get.put(DateInfoController());
    Get.put(EventController());
    // Get.lazyPut(() => ServiceInfoController());
    // Get.lazyPut(() => AdditionalFeeController());
    // Get.lazyPut(() => AddressController());
  }
}
