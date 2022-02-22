import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

IcoOptionModal(
    {String title = '마케팅 이용 동의',
    String subtitle = "마케팅 이용동의에 허용하면\n문자로 아이코코 예약현황 및 소식을\n빠르게 확인할 수 있습니다",
    String option1 = '허용안함',
    String option2 = '허용',
    String iconUrl = "icons/modal_mail.svg"}) {
  void Function() onPressed;
  return Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              width: 335,
              // height: 315,
              decoration: BoxDecoration(
                color: IcoColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconUrl,
                    height: 55,
                    width: 44,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: IcoTextStyle.boldTextStyle22B,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: IcoTextStyle.mediumTextStyle14B,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IcoButton(
                            width: 140,
                            height: 50,
                            onPressed: () => Get.back(result: false),
                            active: true.obs,
                            buttonColor: IcoColors.grey3,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: option1),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 1,
                        child: IcoButton(
                            width: 140,
                            height: 50,
                            onPressed: () => Get.back(result: true),
                            active: true.obs,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: option2),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      barrierDismissible: false);
}

IcoOptionModal2() {
  void Function() onPressed;

  return Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            width: 335,
            // height: 315,
            decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "icons/modal_call.svg",
                  height: 55,
                  width: 44,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "전화상담 시 등록된 정보를\n불러오시겠습니까?",
                  style: IcoTextStyle.boldTextStyle22B,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "마케팅 이용동의에 허용하면\n문자로 아이코코 예약현황 및 소식을\n빠르게 확인할 수 있습니다",
                  textAlign: TextAlign.center,
                  style: IcoTextStyle.mediumTextStyle14B,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IcoButton(
                          width: 140,
                          height: 50,
                          onPressed: () => Get.back(result: false),
                          active: true.obs,
                          buttonColor: IcoColors.grey3,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: "아니오"),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 1,
                      child: IcoButton(
                          width: 140,
                          height: 50,
                          onPressed: () => Get.back(result: true),
                          active: true.obs,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: "네"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
