import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/birth_info_controller.dart';

import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_8_Before extends StatelessWidget {
  ReserveStep2_8_Before({Key? key}) : super(key: key);
  // VoucherController voucherController = Get.find();
  DateInfoController dateInfoController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: IcoAppbar(
          title: "서비스 에약 완료",
          usePop: true,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 31,
                ),
                // SvgPicture.asset(
                //   "icons/failed_human.svg",
                //   width: 166,
                //   height: 162,
                // ),
                SvgPicture.asset(
                  "icons/two_humans.svg",
                  width: 255,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("산후도우미 서비스 예약이\n완료되었습니다!",
                    style: IcoTextStyle.boldTextStyle27B,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "출산 후에 모든 일정이 확정되면,\n산모님께 맞는 산후도우미를 배정해드릴게요!",
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
                            icon: true,
                            iconColor: IcoColors.white,
                            onPressed: () async {
                              //출산 통보 전 step2 끝났을 경우
                              await dateInfoController.updateDateInfoToModel(
                                  authController.reservationModel);
                              await authController.setUserStep(3);
                              await authController.updateReservationFirestore(
                                  authController.reservationNumber.value!);

                              await authController.setModelInfo();
                              Get.offAllNamed(Routes.HOME);
                            },
                            active: true.obs,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "메인 페이지로 돌아가기"),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
