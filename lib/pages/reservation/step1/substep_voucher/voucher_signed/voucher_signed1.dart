import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';

import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed2.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/cost_info_box.dart';
import 'package:app/widgets/dropdown/voucher_dropdown.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherSignedStep1 extends StatelessWidget {
  VoucherSignedStep1({Key? key}) : super(key: key);
  VoucherController voucherController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (authController.reservationModel.value != null) {
      voucherController
          .setVoucherInfo(authController.reservationModel.value!.voucher);
    }

    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          isDefault: false,
          iconColor: IcoColors.white,
          backgroundColor: IcoColors.primary,
          title: "요금 계산",
          usePop: true,
        ),
        floatingActionButton: Obx(() {
          return IcoButton(
              width: IcoSize.width - 40,
              onPressed: () async {
                if (Get.arguments['command'] == "수정") {
                  voucherController
                      .updateVoucherToModel(authController.reservationModel);
                  Get.back(
                      result: authController.reservationModel.value!.voucher);
                } else {
                  Get.toNamed(Routes.VOUCHER_SIGNED2);
                }
              },
              active: (voucherController.showResult.value == true)
                  ? true.obs
                  : false.obs,
              textStyle: IcoTextStyle.buttonTextStyleW,
              text: (Get.arguments['command'] == "수정") ? "수정완료" : "다음으로");
        }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: IcoSize.width,
                height: 245,
                color: IcoColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 27,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "산모님의 등급유형을\n선택해주세요",
                      style: IcoTextStyle.boldTextStyle24W,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "등급유형을 선택 후\n산후도우미 요금 간이 계산이 가능합니다.",
                      style: IcoTextStyle.mediumTextStyle13W,
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: VoucherDropdown(
                                dropDownList:
                                    voucherController.voucherType1List,
                                selectedValue: voucherController.voucherType1),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: VoucherDropdown(
                                dropDownList:
                                    voucherController.voucherType2List,
                                selectedValue: voucherController.voucherType2),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: VoucherDropdown(
                                hintText:
                                    (voucherController.voucherType3.value ==
                                            'C')
                                        ? ''
                                        : null,
                                dropDownList:
                                    voucherController.voucherType3List,
                                selectedValue: voucherController.voucherType3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  return (voucherController.showResult.value)
                      ? Column(
                          children: [
                            Container(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              width: IcoSize.width - 40,
                              height: 82,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: IcoColors.grey3,
                                        blurRadius: 15,
                                        offset: Offset(0, 1)),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "소득구간",
                                        style: IcoTextStyle.boldTextStyle13P,
                                      ),
                                      Text(
                                        "100% 이하",
                                        style: IcoTextStyle.mediumTextStyle16B,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "소득유형",
                                        style: IcoTextStyle.boldTextStyle13P,
                                      ),
                                      Text(
                                        voucherController.voucherResult.value!,
                                        style: IcoTextStyle.mediumTextStyle16B,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  CostInfoBox(
                                    totalFee: voucherController.totalFeeList,
                                    userFee: voucherController.userFeeList,
                                    govermentFee:
                                        voucherController.govermentFeeList,
                                    title: "1주 사용시 요금",
                                    weekIndex: 1,
                                    isVoucherUsed: true.obs,
                                    titleStyle: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  DividerLineWidget(),
                                  CostInfoBox(
                                    totalFee: voucherController.totalFeeList,
                                    userFee: voucherController.userFeeList,
                                    govermentFee:
                                        voucherController.govermentFeeList,
                                    title: "2주 사용시 요금",
                                    weekIndex: 2,
                                    isVoucherUsed: true.obs,
                                    titleStyle: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  DividerLineWidget(),
                                  CostInfoBox(
                                    totalFee: voucherController.totalFeeList,
                                    userFee: voucherController.userFeeList,
                                    govermentFee:
                                        voucherController.govermentFeeList,
                                    title: "3주 사용시 요금",
                                    weekIndex: 3,
                                    isVoucherUsed: true.obs,
                                    titleStyle: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  DividerLineWidget(),
                                  CostInfoBox(
                                    totalFee: voucherController.totalFeeList,
                                    userFee: voucherController.userFeeList,
                                    govermentFee:
                                        voucherController.govermentFeeList,
                                    title: "4주 사용시 요금",
                                    weekIndex: 4,
                                    isVoucherUsed: true.obs,
                                    titleStyle: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  DividerLineWidget(),
                                  CostInfoBox(
                                    totalFee: voucherController.totalFeeList,
                                    userFee: voucherController.userFeeList,
                                    govermentFee:
                                        voucherController.govermentFeeList,
                                    title: "5주 사용시 요금",
                                    weekIndex: 5,
                                    isVoucherUsed: true.obs,
                                    titleStyle: IcoTextStyle.boldTextStyle15P,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    "images/overcost_caution.png",
                                    width: IcoSize.width - 40,
                                  ),
                                  SizedBox(
                                    height: 150,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: double.infinity,
                          child: Text(
                            "바우처 등급 유형을 모두 선택하시면 요금이 표시됩니다.",
                            style: IcoTextStyle.mediumTextStyle15Grey4,
                          ),
                        );
                },
              )
            ],
          ),
        ));
  }
}

class DividerLineWidget extends StatelessWidget {
  DividerLineWidget({
    Key? key,
    this.height = 9,
  }) : super(key: key);
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: IcoColors.grey1,
    );
  }
}
