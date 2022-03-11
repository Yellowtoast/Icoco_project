// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:app/configs/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/voucher_controller.dart';

import 'package:app/helpers/formatter.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';

import 'package:app/controllers/additional_fee_controller.dart';
import 'package:app/models/reservation.dart';
import 'package:app/pages/reservation/step2/reserve/reserve_step2_7_novoucher.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

BottomResultModal() {
  AdditionalFeeController additionalFeeController = Get.find();
  AuthController authController = Get.find();
  VoucherController voucherController = Get.find();
  return Get.bottomSheet(
      Container(
        height: 380,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        width: IcoSize.width,
        decoration: BoxDecoration(
          color: IcoColors.white,
          boxShadow: [
            BoxShadow(
                color: IcoColors.grey3, blurRadius: 15, offset: Offset(0, -3)),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("총 추가요금", style: IcoTextStyle.boldTextStyle15P),
            SizedBox(
              height: 6,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                    "${numFormat.format(additionalFeeController.totalAdditionalFee)}원",
                    style: IcoTextStyle.boldTextStyle24B),
                Text(" / 일", style: IcoTextStyle.boldTextStyle14B)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              color: IcoColors.grey3,
            ),
            SizedBox(
              height: 16,
            ),
            (additionalFeeController.preschooler != null)
                ? Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "미취학아동",
                                textAlign: TextAlign.left,
                                style: IcoTextStyle.boldTextStyle15B,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                  additionalFeeController.preschooler
                                          .toString() +
                                      "명",
                                  style: IcoTextStyle.mediumTextStyle15P),
                            ),
                            Expanded(
                              child: Text(
                                  "${numFormat.format(additionalFeeController.preschoolerFee)}원 / 일",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.boldTextStyle15B),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : SizedBox(),
            (additionalFeeController.kindergartener != null)
                ? Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "유치원/어린이집",
                                textAlign: TextAlign.left,
                                style: IcoTextStyle.boldTextStyle15B,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                  additionalFeeController.kindergartener
                                          .toString() +
                                      "명",
                                  style: IcoTextStyle.mediumTextStyle15P),
                            ),
                            Expanded(
                              child: Text(
                                  "${numFormat.format(additionalFeeController.kindergartenFee)}원 / 일",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.boldTextStyle15B),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : SizedBox(),
            (additionalFeeController.schooler != null)
                ? Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "초등생 이상",
                                textAlign: TextAlign.left,
                                style: IcoTextStyle.boldTextStyle15B,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                  additionalFeeController.schooler.toString() +
                                      "명",
                                  style: IcoTextStyle.mediumTextStyle15P),
                            ),
                            Expanded(
                              child: Text(
                                  "${numFormat.format(additionalFeeController.schoolerFee)}원 / 일",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.boldTextStyle15B),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : SizedBox(),
            (additionalFeeController.extraFamily != null)
                ? SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "기타가족",
                            textAlign: TextAlign.left,
                            style: IcoTextStyle.boldTextStyle15B,
                          ),
                        ),
                        Expanded(
                          child: Text(
                              additionalFeeController.extraFamily.toString() +
                                  "명",
                              style: IcoTextStyle.mediumTextStyle15P),
                        ),
                        Expanded(
                          child: Text(
                              "${numFormat.format(additionalFeeController.extraFamilyFee)}원 / 일",
                              textAlign: TextAlign.right,
                              style: IcoTextStyle.boldTextStyle15B),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 50,
            ),
            IcoButton(
                onPressed: () {
                  additionalFeeController
                      .updateReservationModel(authController.reservationModel);
                  if (authController.reservationModel.value!.userStep == 2) {
                    if (authController.reservationModel.value!.isBirth ==
                        true) {
                      Get.toNamed(Routes.RESERVE_STEP2_6,
                          preventDuplicates: false);
                    } else {
                      voucherController.setDropDownList(null);
                      voucherController.setVoucherInfo(
                          voucherController.voucherResult.value,
                          additionalFeeController.totalAdditionalFee);
                      if (authController.reservationModel.value!.voucher ==
                          '일반서비스') {
                        Get.to(ReserveStep2_7_Novoucher());
                      } else {
                        Get.toNamed(Routes.RESERVE_STEP2_7,
                            preventDuplicates: false);
                      }
                    }
                  } else {
                    Get.toNamed(
                      Routes.RESERVE_STEP2_FINISHED,
                    );
                  }
                },
                active: true.obs,
                textStyle: IcoTextStyle.buttonTextStyleW,
                text: "다음으로"),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      barrierColor: Colors.black12,
      isDismissible: true);
}
