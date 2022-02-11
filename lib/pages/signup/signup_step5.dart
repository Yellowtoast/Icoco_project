import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';

import 'package:app/pages/signup/signup_step6_intro.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupStep5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IcoAppbar(
        title: "회원가입 완료",
        usePop: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("회원가입이\n완료되었습니다!",
                        style: IcoTextStyle.boldTextStyle27B,
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "아이코코와 함께 나에게 맞는\n산후도우미를 만나보세요",
                      style: IcoTextStyle.mediumTextStyle14B,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SvgPicture.asset(
                      "icons/two_humans.svg",
                      width: IcoSize.width - 100,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: IcoButton(
                    icon: false,
                    onPressed: () {
                      Get.toNamed(Routes.SIGNUP_STEP6);
                    },
                    active: true.obs,
                    buttonColor: IcoColors.primary,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: "아이코코 시작하기"),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
