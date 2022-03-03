import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/pages/reservation/step1/substep_address/address1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeStep1Items extends StatelessWidget {
  HomeStep1Items({Key? key}) : super(key: key);
  AddressController addressController = Get.find();
  @override
  Widget build(BuildContext context) {
    return IcoButton(
      active: true.obs,
      buttonColor: IcoColors.primary,
      textStyle: IcoTextStyle.buttonTextStyleW,
      text: "정부지원 조회로 예약 시작",
      onPressed: () async {
        Get.toNamed(Routes.ADDRESS_1);
      },
    );
  }
}
