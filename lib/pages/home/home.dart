// ignore_for_file: prefer_const_constructors
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/autoscroll_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/pages/home/home_skeleton.dart';
import 'package:app/widgets/tabbar/bottom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/controllers/home_controller.dart';
import '../calculator/calculator.dart';
import '../event/event.dart';
import '../mypage/mypage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController homeController = Get.find();
  AuthController authController = Get.find();
  VoucherController voucherController = Get.find();

  Rx<int> navBarIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          bottomNavigationBar: IcoBottomBar(
              selectedIndex: navBarIndex.value,
              onTap: (value) async {
                navBarIndex.value = value;
              }),
          body: _homePagechildren[navBarIndex.value]);
    });
  }

  final List<Widget> _homePagechildren = [
    HomeSkeletonPage(),
    CalculatorPage(),
    EventPage(),
    MyPage()
  ];
}
