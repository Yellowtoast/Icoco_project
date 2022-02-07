import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: IcoSize.width - 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'icons/picon1.png',
                width: Get.width * 0.37,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '산후도우미 예약 복잡하고 어렵다면',
                style: IcoTextStyle.headingStyleMedium,
              ),
              Text(
                '지금 바로 아이코코와 함께하세요',
                style: GoogleFonts.notoSans(
                    fontSize: 20,
                    color: IcoColors.primary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 18,
              ),
              IcoButton(
                active: true.obs,
                icon: true,
                leadingIcon: false,
                iconColor: IcoColors.primary,
                border: true,
                buttonColor: IcoColors.white,
                textStyle: IcoTextStyle.buttonTextStyleP,
                text: "로그인하기",
                onPressed: () => Get.toNamed(Routes.LOGIN),
              ),
              SizedBox(
                height: 18,
              ),
              IcoButton(
                active: true.obs,
                icon: true,
                leadingIcon: false,
                iconColor: IcoColors.white,
                border: false,
                buttonColor: IcoColors.primary,
                textStyle: IcoTextStyle.buttonTextStyleW,
                text: "회원가입하기",
                onPressed: () {
                  Get.toNamed(Routes.SIGNUP_STEP1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
