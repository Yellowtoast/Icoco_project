import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';

import 'package:app/pages/loading.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VoucherSignedStep3 extends StatelessWidget {
  VoucherSignedStep3({Key? key}) : super(key: key);
  VoucherController voucherController = Get.find();
  // ReservationController reservationController = Get.find();
  AddressController addressController = Get.find();
  HomeController homeController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text("바우처 서비스\n사용준비가 완료되었습니다!",
                    style: IcoTextStyle.boldTextStyle27B,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "지금 바로 아이코코를 시작해보세요!",
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
                              startLoadingIndicator();
                              await authController.createReservationFirestore(
                                  authController.userModel.value!,
                                  addressController.completeAddress.value!,
                                  voucherController.getFullRegNum(),
                                  2,
                                  voucherController.voucherResult.value!);

                              await authController.setModelInfo();
                              finishLoadingIndicator();
                              Get.offAllNamed(Routes.HOME);
                            },
                            active: true.obs,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "아이코코 시작하기"),
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
