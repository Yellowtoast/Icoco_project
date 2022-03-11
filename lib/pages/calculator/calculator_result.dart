import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/voucher_controller.dart';

import 'package:app/widgets/loading/loading.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/info_box/cost_info_box.dart';
import 'package:app/widgets/dropdown/voucher_dropdown.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CalculatorResultPage extends StatelessWidget {
  CalculatorResultPage({Key? key}) : super(key: key);

  VoucherController voucherController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var voucher = Get.arguments;
    voucherController.setVoucherInfo(voucher, 0);
    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          hasShadow: true,
          iconColor: IcoColors.white,
          backgroundColor: IcoColors.purple2,
          title: "요금 계산",
          usePop: true,
        ),
        floatingActionButton: IcoButton(
            width: IcoSize.width - 40,
            onPressed: () async {
              loading(() => authController.setModelInfo());
              Get.offAllNamed(Routes.HOME);
            },
            active: true.obs,
            textStyle: IcoTextStyle.buttonTextStyleW,
            text: "메인 홈으로"),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: IcoSize.width,
                height: 245,
                color: IcoColors.purple2,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 27,
                    ),
                    Text(
                      "2021년도 산후도우미\n정부지원금 (표준)",
                      style: IcoTextStyle.boldTextStyle24P,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "2018/7/1일부로 나형과 다형이 통합되었습니다.\n\n지역에 따라 정책이 다를 수 있습니다.\n자세한 내용은 지역 보건소에서 확인하여주시기 바랍니다.",
                      style: IcoTextStyle.mediumTextStyle13B,
                    ),
                    SizedBox(
                      height: 19,
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
                              height: 200,
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
                                        "등급유형",
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
                                    height: 120,
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
