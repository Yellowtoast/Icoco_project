import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeStep2Items extends StatelessWidget {
  const HomeStep2Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IcoButton(
      active: true.obs,
      buttonColor: IcoColors.primary,
      textStyle: IcoTextStyle.buttonTextStyleW,
      text: "예약 신청하기",
      onPressed: () {
        Get.toNamed(Routes.RESERVE_STEP2_1);
      },
    );
  }
}
