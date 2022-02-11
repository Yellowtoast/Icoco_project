import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';

import 'package:app/models/reservation.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_Finished extends StatelessWidget {
  ReserveStep2_Finished({Key? key}) : super(key: key);
  // VoucherController voucherController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: IcoAppbar(
          title: "서비스 예약 완료",
          usePop: false,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 31,
                ),
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
                  "산후도우미가 배정되면 산모님께\n문자메시지와 푸쉬로 알려드릴게요!",
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
                            icon: false,
                            onPressed: () async {
                              authController.reservationModel.value!.isBirth =
                                  true;
                              authController.reservationModel.value!.status =
                                  '예약 (출산일 확정)';
                              await authController.updateReservationFirestore(
                                  authController.reservationModel.value!
                                      .reservationNumber);

                              await authController.setModelInfo();
                              Get.offAllNamed(Routes.HOME);
                            },
                            active: true.obs,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "메인페이지로 돌아가기"),
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
