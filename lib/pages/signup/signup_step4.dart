import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/fcm_controller.dart';
import 'package:app/pages/signup/signup_step5.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupStep4Page extends StatelessWidget {
  SignupStep4Page({Key? key}) : super(key: key);

  FCMController _fcmController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IcoAppbar(title: "알림 동의"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "산모님의 원활한 예약을 위해\n",
                        style: IcoTextStyle.boldTextStyle24B,
                        children: <TextSpan>[
                          TextSpan(
                              text: '알람 동의',
                              style: IcoTextStyle.boldTextStyle24P),
                          TextSpan(
                              text: '가 꼭 필요합니다',
                              style: IcoTextStyle.boldTextStyle24B),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "산후도우미 서비스의 예약을 위해서\n산모님의",
                        style: IcoTextStyle.mediumTextStyle14B,
                        children: <TextSpan>[
                          TextSpan(
                              text: '알림(푸쉬) 동의',
                              style: IcoTextStyle.boldTextStyle14P),
                          TextSpan(
                              text: '가 꼭 필요합니다.',
                              style: IcoTextStyle.mediumTextStyle14B),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text.rich(
                      TextSpan(
                        text: "아이코코는 푸쉬알림 미동의로 인해 발생하는\n",
                        style: IcoTextStyle.mediumTextStyle14B,
                        children: <TextSpan>[
                          TextSpan(
                              text: '예약 취소나 지연 등 모든 문제에 대해\n책임이 없음을 알려드립니다',
                              style: IcoTextStyle.boldTextStyle14P),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    Image.asset(
                      "images/alarm.png",
                      width: IcoSize.width - 80,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: IcoButton(
                    icon: false,
                    onPressed: () async {
                      await _fcmController.getPermissionFromUser();
                      if (_fcmController.proceedSignup.value) {
                        Get.toNamed(Routes.SIGNUP_STEP5);
                      }
                    },
                    active: true.obs,
                    buttonColor: IcoColors.primary,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: "알람 허용하기"),
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
