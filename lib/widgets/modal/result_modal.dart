// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:app/configs/colors.dart';
import 'package:app/controllers/auth_controller.dart';

import 'package:app/helpers/formatter.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';

import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
import 'package:app/models/reservation.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomResultModal extends StatelessWidget {
  BottomResultModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdditionalFeeController extraChargeController = Get.find();
    AuthController authController = Get.find();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          width: IcoSize.width,
          decoration: BoxDecoration(
            color: IcoColors.white,
            boxShadow: [
              BoxShadow(
                  color: IcoColors.grey3,
                  blurRadius: 15,
                  offset: Offset(0, -3)),
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
                      "${numFormat.format(extraChargeController.totalAdditionalFee)}원",
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
              (extraChargeController.preschooler != null)
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
                              Expanded(
                                child: Text(
                                    extraChargeController.preschooler
                                            .toString() +
                                        "명",
                                    style: IcoTextStyle.mediumTextStyle15P),
                              ),
                              Expanded(
                                child: Text(
                                    "${numFormat.format(extraChargeController.preschoolerFee)}원 / 일",
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
              (extraChargeController.kindergartener != null)
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
                                    extraChargeController.kindergartener
                                            .toString() +
                                        "명",
                                    style: IcoTextStyle.mediumTextStyle15P),
                              ),
                              Expanded(
                                child: Text(
                                    "${numFormat.format(extraChargeController.kindergartenFee)}원 / 일",
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
              (extraChargeController.schooler != null)
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
                                    extraChargeController.schooler.toString() +
                                        "명",
                                    style: IcoTextStyle.mediumTextStyle15P),
                              ),
                              Expanded(
                                child: Text(
                                    "${numFormat.format(extraChargeController.schoolerFee)}원 / 일",
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
              (extraChargeController.extraFamily != null)
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
                                extraChargeController.extraFamily.toString() +
                                    "명",
                                style: IcoTextStyle.mediumTextStyle15P),
                          ),
                          Expanded(
                            child: Text(
                                "${numFormat.format(extraChargeController.extraFamilyFee)}원 / 일",
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
                  onPressed: () async {
                    extraChargeController.updateReservationModel();
                    if (authController.reservationModel.value!.isBirth ==
                        true) {
                      Get.toNamed(Routes.RESERVE_STEP2_6);
                    } else {
                      Get.toNamed(Routes.RESERVE_STEP2_7);
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
        )
      ],
    );
  }
}
