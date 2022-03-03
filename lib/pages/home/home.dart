// ignore_for_file: prefer_const_constructors
import 'package:app/controllers/auth_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          bottomNavigationBar: IcoBottomBar(
              selectedIndex: navBarIndex,
              onTap: (value) async {
                navBarIndex.value = value;
                if (value == 0) {}
              }),
          body: _homePagechildren[navBarIndex.value]);
    });
  }

  Rx<int> navBarIndex = 0.obs;
  final List<Widget> _homePagechildren = [
    HomeSkeletonPage(),
    CalculatorPage(),
    EventPage(),
    MyPage()
  ];
}
