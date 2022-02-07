import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future<dynamic> IcoWarningModal(onPressed) {
  return Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        //fit size of modal to container size
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            width: 335,
            height: 404,
            decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/modal_warning_human.png",
                  height: 145,
                  width: 147,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "반드시 산모님의 정보로\n 기입해주세요!",
                  textAlign: TextAlign.center,
                  style: IcoTextStyle.boldTextStyle22B,
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "주민번호 뒷자리의 첫번째 숫자는 산모님의\n정보에 맞게 2 또는 4로 입력되어야합니다.",
                  textAlign: TextAlign.center,
                  style: IcoTextStyle.mediumTextStyle14B,
                ),
                SizedBox(
                  height: 30,
                ),
                IcoButton(
                    height: 50,
                    onPressed: onPressed,
                    active: true.obs,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: "다시 입력하기"),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
