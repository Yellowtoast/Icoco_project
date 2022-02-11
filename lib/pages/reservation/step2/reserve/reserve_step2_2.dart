import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';

import 'package:app/pages/reservation/step1/substep_address/address1.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed3.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_3_beforebirth.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_3_afterbirth.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/textfield/regnum_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReserveStep2_2 extends StatelessWidget {
  ReserveStep2_2({Key? key}) : super(key: key);
  VoucherController voucherController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(title: '예약하기'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 27,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '현재 출산을 하셨나요?',
                  style: IcoTextStyle.boldTextStyle24B,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '산모님의 출산 여부를 알려주세요',
                  style: IcoTextStyle.mediumTextStyle13B,
                ),
                SizedBox(
                  height: 20,
                ),
                IcoButton(
                    onPressed: () {
                      authController.reservationModel.value!.isBirth = true;
                      authController.reservationModel.value!.status = '예약출산일확정';
                      Get.toNamed(Routes.RESERVE_STEP2_3_AFTER);
                    },
                    active: true.obs,
                    textStyle: IcoTextStyle.buttonTextStyleB,
                    text: "네",
                    buttonColor: IcoColors.grey1),
                SizedBox(
                  height: 14,
                ),
                IcoButton(
                    onPressed: () {
                      authController.reservationModel.value!.isBirth = false;
                      authController.reservationModel.value!.status =
                          '예약출산일미확정';
                      Get.toNamed(Routes.RESERVE_STEP2_3_BEFORE);
                    },
                    active: true.obs,
                    textStyle: IcoTextStyle.buttonTextStyleB,
                    text: "아니오",
                    buttonColor: IcoColors.grey1)
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
