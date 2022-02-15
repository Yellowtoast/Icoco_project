import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/password_controller.dart';
import 'package:app/helpers/validator.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FindPasswordPage3 extends StatelessWidget {
  FindPasswordPage3({Key? key}) : super(key: key);
  PasswordController passwordController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IcoAppbar(
        title: '비밀번호 변경',
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
                    SvgPicture.asset(
                      "icons/loading.svg",
                      width: 140,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text("비밀번호가 정상적으로\n변경되었습니다",
                        style: IcoTextStyle.boldTextStyle27B,
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "변경된 비밀번호로 재로그인 후\n아이코코 서비스를 사용해보세요",
                      style: IcoTextStyle.mediumTextStyle14B,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: IcoButton(
                    icon: false,
                    onPressed: () {
                      Get.offAllNamed(Routes.START);
                    },
                    active: true.obs,
                    buttonColor: IcoColors.primary,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: "로그인하기"),
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
