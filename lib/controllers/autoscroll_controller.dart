import 'package:app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AutoScrollController extends GetxController {
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  final HomeController _homeController = Get.find();
  RxDouble scrollPixels = 0.0.obs;
  RxInt homeIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {});
  }

  @override
  void onReady() {
    super.onReady();
    startScrollController();
  }

  startScrollController() async {
    if (scrollController.hasClients) {
      scrollPixels.value = (_homeController.userStep.value - 1) * 164;
      await scrollController.animateTo(scrollPixels.value,
          duration: Duration(milliseconds: 600), curve: Curves.decelerate);
    }
  }

  startScroll(int step) async {
    if (scrollController2.hasClients) {
      await scrollController2.animateTo((step - 1) * 128,
          duration: Duration(milliseconds: 300), curve: Curves.decelerate);
    }
  }
}
