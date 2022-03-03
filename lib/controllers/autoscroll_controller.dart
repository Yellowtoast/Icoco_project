import 'package:app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AutoScrollController extends GetxController {
  ScrollController scrollController = ScrollController();
  final HomeController _homeController = Get.find();
  RxDouble _scrollPixels = 0.0.obs;

  @override
  void onInit() {
    scrollController.addListener(() {});
    super.onInit();
  }

  @override
  void onReady() {
    _scrollPixels.value = (_homeController.userStep.value - 1) * 164;
    scrollController.animateTo(_scrollPixels.value,
        duration: Duration(milliseconds: 900), curve: Curves.decelerate);
    super.onReady();
  }
}
