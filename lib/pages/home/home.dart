// ignore_for_file: prefer_const_constructors

import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/calculator_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/reservation_controller.dart';
import 'package:app/pages/home/home_skeleton.dart';
import 'package:app/widgets/bottom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../calculator.dart';
import '../event.dart';
import '../mypage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController homeController = Get.find();
  AuthController authController = Get.find();
  AddressController addressController = Get.find();

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
