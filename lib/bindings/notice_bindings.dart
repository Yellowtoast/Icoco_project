import 'package:app/controllers/login_controller.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:get/get.dart';

class NoticeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NoticeController());
  }
}
