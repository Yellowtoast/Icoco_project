import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: Get.width - 190,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '처음 만나는 산후도우미 매칭 플랫폼',
              style: IcoTextStyle.initPageTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
