import 'package:app/configs/colors.dart';
import 'package:app/configs/formats.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';

import 'package:app/models/reservation.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future<dynamic> DepositCostStatusPopup() {
  void Function() onPressed;
  AuthController authController = Get.find();
  Rxn<ReservationModel?> reservationModel = authController.reservationModel;
  String title;
  String subTitle;

  return Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 20),
            width: 335,
            height: 525,
            decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "μκΈ μλ£",
                      textAlign: TextAlign.center,
                      style: IcoTextStyle.boldTextStyle15B,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: IcoColors.grey3,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "μμ½κΈ μκΈ μλ£",
                        textAlign: TextAlign.center,
                        style: IcoTextStyle.boldTextStyle22B,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        "μμ½κΈ μκΈ μλ£μ²λ¦¬ λμμ΅λλ€.\nμκΈλ΄μ©κ³Ό λ€λ₯΄λ€λ©΄ κ³ κ°μΌν°λ‘ λ¬Έμν΄μ£ΌμΈμ",
                        textAlign: TextAlign.center,
                        style: IcoTextStyle.mediumTextStyle14B,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: IcoColors.grey1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μμ½κΈ",
                                  style: IcoTextStyle.boldTextStyle13P,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "${decimalFormat.format(reservationModel.value!.depositCost)} μ μκΈ",
                                  style: IcoTextStyle.boldTextStyle16P,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μκΈ",
                                  style: IcoTextStyle.mediumTextStyle13Grey4,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "+ ${decimalFormat.format(reservationModel.value!.balanceCost)} μ μκΈ",
                                  style: IcoTextStyle.mediumTextStyle16Grey4,
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: IcoColors.grey3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μ΄ λ³ΈμΈλΆλ΄κΈ",
                                  style: IcoTextStyle.boldTextStyle13P,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "${decimalFormat.format(reservationModel.value!.balanceCost)} μ",
                                  style: IcoTextStyle.boldTextStyle16P,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      IcoButton(
                          width: 292,
                          height: 50,
                          onPressed: () {},
                          active: true.obs,
                          buttonColor: IcoColors.grey4,
                          textStyle: IcoTextStyle.boldTextStyle16W,
                          text: "κ³ κ°μΌν° λ¬ΈμνκΈ°"),
                      SizedBox(
                        height: 15,
                      ),
                      IcoButton(
                          width: 292,
                          height: 50,
                          onPressed: () async {
                            authController.reservationModel.value!.openPopup =
                                false;
                            authController.setUserStep(4);
                            authController.updateReservationFirestore(
                                reservationModel.value!.reservationNumber);

                            await authController.setModelInfo();
                            Get.offAllNamed(Routes.HOME);
                          },
                          active: true.obs,
                          textStyle: IcoTextStyle.boldTextStyle16W,
                          text: "νμΈ (λ©μΈνμ΄μ§λ‘)"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 7,
            top: 0,
            child: IconButton(
                onPressed: () async {
                  authController.setUserStep(4);
                  authController.updateReservationFirestore(
                      reservationModel.value!.reservationNumber);

                  await authController.setModelInfo();
                  Get.offAllNamed(Routes.HOME);
                },
                icon: SvgPicture.asset(
                  "icons/modal_close.svg",
                  width: 24,
                  height: 24,
                )),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

Future<dynamic> RemainingCostStatusPopup() {
  void Function() onPressed;
  AuthController authController = Get.find();
  Rxn<ReservationModel?> reservationModel = authController.reservationModel;
  String title;
  String subTitle;

  return Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 20),
            width: 335,
            height: 525,
            decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "μκΈ μλ£",
                      textAlign: TextAlign.center,
                      style: IcoTextStyle.boldTextStyle15B,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: IcoColors.grey3,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "μκΈ μκΈ μλ£",
                        textAlign: TextAlign.center,
                        style: IcoTextStyle.boldTextStyle22B,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        "μκΈ μκΈ μλ£μ²λ¦¬ λμμ΅λλ€.\nμκΈλ΄μ©κ³Ό λ€λ₯΄λ€λ©΄ κ³ κ°μΌν°λ‘ λ¬Έμν΄μ£ΌμΈμ",
                        textAlign: TextAlign.center,
                        style: IcoTextStyle.mediumTextStyle14B,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: IcoColors.grey1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μμ½κΈ",
                                  style: IcoTextStyle.mediumTextStyle13Grey4,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "${decimalFormat.format(reservationModel.value!.depositCost)} μ μκΈ",
                                  style: IcoTextStyle.lineBoldTextStyle15Grey4,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μκΈ",
                                  style: IcoTextStyle.boldTextStyle13P,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "+ ${decimalFormat.format(reservationModel.value!.balanceCost)} μ μκΈ",
                                  style: IcoTextStyle.boldTextStyle16P,
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: IcoColors.grey3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μ΄ λ³ΈμΈλΆλ΄κΈ",
                                  style: IcoTextStyle.boldTextStyle13P,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "${decimalFormat.format(reservationModel.value!.userCost)} μ",
                                  style: IcoTextStyle.mediumTextStyle16P,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      IcoButton(
                          width: 292,
                          height: 50,
                          onPressed: () {},
                          active: true.obs,
                          buttonColor: IcoColors.grey4,
                          textStyle: IcoTextStyle.boldTextStyle16W,
                          text: "κ³ κ°μΌν° λ¬ΈμνκΈ°"),
                      SizedBox(
                        height: 15,
                      ),
                      IcoButton(
                          width: 292,
                          height: 50,
                          onPressed: () async {
                            authController.reservationModel.value!.openPopup =
                                false;
                            authController.setUserStep(5);
                            await authController.updateReservationFirestore(
                                reservationModel.value!.reservationNumber);

                            await authController.setModelInfo();
                            Get.offAllNamed(Routes.HOME);
                          },
                          active: true.obs,
                          textStyle: IcoTextStyle.boldTextStyle16W,
                          text: "νμΈ (λ©μΈνμ΄μ§λ‘)"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 7,
            top: 0,
            child: IconButton(
                onPressed: () {
                  // authController.setModelInfo();
                  // Get.offAllNamed(Routes.HOME);
                  Get.back();
                },
                icon: SvgPicture.asset(
                  "icons/modal_close.svg",
                  width: 24,
                  height: 24,
                )),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

Future<dynamic> UserCostStatusPopup() {
  void Function() onPressed;
  // ReservationController reservationController = Get.find();
  AuthController authController = Get.find();
  Rxn<ReservationModel?> reservationModel = authController.reservationModel;
  String title;
  String subTitle;

  return Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 20),
            width: 335,
            height: 525,
            decoration: BoxDecoration(
              color: IcoColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "μκΈ μλ£",
                      textAlign: TextAlign.center,
                      style: IcoTextStyle.boldTextStyle15B,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: IcoColors.grey3,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "λ³ΈμΈλΆλ΄κΈ μκΈ μλ£",
                        textAlign: TextAlign.center,
                        style: IcoTextStyle.boldTextStyle22B,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        "μμ½κΈκ³Ό μκΈμ΄ ν¨κ» μκΈλμλ€μ.\nμκΈλ΄μ©κ³Ό λ€λ₯΄λ€λ©΄ κ³ κ°μΌν°λ‘ λ¬Έμν΄μ£ΌμΈμ",
                        textAlign: TextAlign.center,
                        style: IcoTextStyle.mediumTextStyle14B,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: IcoColors.grey1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μμ½κΈ",
                                  style: IcoTextStyle.mediumTextStyle13Grey4,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "${decimalFormat.format(reservationModel.value!.depositCost)} μ μκΈ",
                                  style: IcoTextStyle.lineBoldTextStyle15Grey4,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μκΈ",
                                  style: IcoTextStyle.boldTextStyle13Grey4,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "+ ${decimalFormat.format(reservationModel.value!.balanceCost)} μ μκΈ",
                                  style: IcoTextStyle.lineBoldTextStyle15Grey4,
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: IcoColors.grey3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "μ΄ λ³ΈμΈλΆλ΄κΈ",
                                  style: IcoTextStyle.boldTextStyle13P,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "${decimalFormat.format(reservationModel.value!.userCost)} μ",
                                  style: IcoTextStyle.boldTextStyle16P,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      IcoButton(
                          width: 292,
                          height: 50,
                          onPressed: () {},
                          active: true.obs,
                          buttonColor: IcoColors.grey4,
                          textStyle: IcoTextStyle.boldTextStyle16W,
                          text: "κ³ κ°μΌν° λ¬ΈμνκΈ°"),
                      SizedBox(
                        height: 15,
                      ),
                      IcoButton(
                          width: 292,
                          height: 50,
                          onPressed: () async {
                            authController.reservationModel.value!.openPopup =
                                false;
                            authController.setUserStep(5);
                            authController.updateReservationFirestore(
                                reservationModel.value!.reservationNumber);

                            await authController.setModelInfo();
                            await authController.setModelInfo();
                            Get.offAllNamed(Routes.HOME);
                          },
                          active: true.obs,
                          textStyle: IcoTextStyle.boldTextStyle16W,
                          text: "νμΈ (λ©μΈνμ΄μ§λ‘)"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 7,
            top: 0,
            child: IconButton(
                onPressed: () async {
                  authController.setUserStep(5);
                  await authController.updateReservationFirestore(
                      reservationModel.value!.reservationNumber);

                  await authController.setModelInfo();
                  Get.offAllNamed(Routes.HOME);
                },
                icon: SvgPicture.asset(
                  "icons/modal_close.svg",
                  width: 24,
                  height: 24,
                )),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}
