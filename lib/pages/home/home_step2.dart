import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeStep2Items extends StatelessWidget {
  HomeStep2Items({Key? key}) : super(key: key);

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return IcoButton(
      active: true.obs,
      buttonColor: IcoColors.primary,
      textStyle: IcoTextStyle.buttonTextStyleW,
      text: "예약 신청하기",
      onPressed: () {
        // if (authController.reservationModel.value!.voucher != null) {
        //   voucherController.voucherResult.value =
        //       authController.reservationModel.value!.voucher!;

        // }

        Get.toNamed(Routes.RESERVE_STEP2_1);
      },
    );
  }
}
