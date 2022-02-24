import 'package:app/controllers/event_detail_controller.dart';

import 'package:get/get.dart';

class EventDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(EventDetailController());
  }
}
