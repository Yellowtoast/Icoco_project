import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';

import 'package:app/pages/reservation/fee_guide/fee_guide.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_unused/service_fee_info.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_Registered extends StatelessWidget {
  ReserveStep2_Registered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    DateInfoController dateInfoController = Get.find();
    ServiceInfoController serviceInfoController = Get.find();

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
                  height: 80,
                ),
                SvgPicture.asset(
                  "icons/register_paper.svg",
                  height: 99,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("산후도우미 서비스가\n신청되었습니다!",
                    style: IcoTextStyle.boldTextStyle27B,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "예약금 입금까지 진행해야\n산후도우미 서비스 예약이 완료됩니다.",
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
                            onPressed: () {
                              serviceInfoController.updateServiceInfoToModel(
                                  authController.reservationModel);
                              dateInfoController.updateDateInfoToModel(
                                  authController.reservationModel);
                              if (authController
                                      .reservationModel.value!.userStep ==
                                  2) {
                                authController.setUserStep(3);
                              } else if (authController
                                      .reservationModel.value!.userStep >
                                  2) {
                                authController.reservationModel.value!.isBirth =
                                    true;
                              }
                              print(authController
                                  .reservationModel.value!.reservationNumber);
                              authController.updateReservationFirestore(
                                  authController.reservationModel.value!
                                      .reservationNumber);

                              Get.to(() => FeeGuidePages());
                            },
                            active: true.obs,
                            buttonColor: IcoColors.primary,
                            borderColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "예약금 입금 안내"),
                        SizedBox(
                          height: 15,
                        ),
                        IcoButton(
                            border: true,
                            icon: true,
                            iconColor: IcoColors.primary,
                            onPressed: () async {
                              serviceInfoController.updateServiceInfoToModel(
                                  authController.reservationModel);
                              await dateInfoController.updateDateInfoToModel(
                                  authController.reservationModel);
                              if (authController
                                      .reservationModel.value!.userStep ==
                                  2) {
                                await authController.setUserStep(3);
                              } else if (authController
                                      .reservationModel.value!.userStep >
                                  2) {
                                authController.reservationModel.value!.isBirth =
                                    true;
                              }

                              await authController.updateReservationFirestore(
                                  authController.reservationModel.value!
                                      .reservationNumber);

                              Get.offAllNamed(Routes.HOME);
                            },
                            active: true.obs,
                            buttonColor: IcoColors.white,
                            borderColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleP,
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
