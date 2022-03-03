import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widgets/loading/loading.dart';

class AddressPage3 extends StatelessWidget {
  const AddressPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: IcoAppbar(
            title: "미오픈지역 안내",
            usePop: true,
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 31,
                  ),
                  Image.asset(
                    "icons/failed_human.png",
                    width: 166,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "등록하신 지역은 서비스\n가능 지역이 아닙니다 :(",
                    style: IcoTextStyle.boldTextStyle27B,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "서비스 지역 범위를 확장하는 중입니다\n이용에 불편을 드려 죄송합니다.\n해당 지역 관할 보건소의\n출산보육지원과에 문의해보세요.",
                    style: IcoTextStyle.mediumTextStyle14B,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IcoButton(
                              iconColor: IcoColors.primary,
                              icon: true,
                              border: true,
                              onPressed: () async {
                                await launch(
                                    'https://www.g-health.kr/portal/health/pubHealthSearch/list.do?bbsId=U00198&menuNo=200452');
                              },
                              active: true.obs,
                              buttonColor: IcoColors.white,
                              textStyle: IcoTextStyle.buttonTextStyleP,
                              text: "보건소 찾아보기"),
                          SizedBox(
                            height: 17,
                          ),
                          IcoButton(
                              icon: true,
                              iconColor: IcoColors.white,
                              onPressed: () {
                                AuthController authController = Get.find();
                                authController.setModelInfo();
                                Get.offAllNamed(Routes.HOME);
                              },
                              active: true.obs,
                              buttonColor: IcoColors.primary,
                              textStyle: IcoTextStyle.buttonTextStyleW,
                              text: "메인페이지로 돌아가기"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
