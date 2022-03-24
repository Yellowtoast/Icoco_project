import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/info_box/cost_info_box.dart';
import 'package:app/widgets/dropdown/voucher_dropdown.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherNormalService extends StatelessWidget {
  VoucherNormalService({Key? key}) : super(key: key);
  VoucherController voucherController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    voucherController.voucherType1List = ['일반'].obs;
    voucherController.voucherType2List = ['단태아', '쌍태아', '삼태아'].obs;
    voucherController.voucherType3List = [''].obs;
    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          hasShadow: false,
          iconColor: IcoColors.white,
          backgroundColor: IcoColors.primary,
          title: "요금 계산",
          usePop: true,
        ),
        floatingActionButton: Obx(() {
          return IcoButton(
              width: IcoSize.width - 40,
              onPressed: () {
                if (Get.arguments['command'] == "수정") {
                  voucherController
                      .updateVoucherToModel(authController.reservationModel);
                  authController.updateReservationFirestore(
                      authController.reservationModel.value!.reservationNumber);
                  Get.back();
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Obx(() {
          return SingleChildScrollView(
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
                        "일반서비스 사용유형을\n선택해주세요",
                        style: IcoTextStyle.boldTextStyle24W,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "일반서비스 유형을 선택 후\n산후도우미 요금 간이 계산이 가능합니다.",
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
                                  selectedVoucherType:
                                      voucherController.voucherType1),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: VoucherDropdown(
                                  dropDownList:
                                      voucherController.voucherType2List,
                                  selectedVoucherType:
                                      voucherController.voucherType2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                (voucherController.showResult.value)
                    ? Column(
                        children: [
                          Container(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            width: IcoSize.width - 40,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(168, 183, 183, 183),
                                      blurRadius: 15,
                                      offset: Offset(0, 1)),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "서비스유형",
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
                                Container(
                                  alignment: Alignment.center,
                                  width: IcoSize.width - 40,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: IcoColors.grey1,
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                        style: IcoTextStyle.boldTextStyle22B,
                                        children: [
                                          TextSpan(
                                              text: '정부지원금',
                                              style: IcoTextStyle
                                                  .boldTextStyle15P),
                                          TextSpan(
                                              text: '은',
                                              style: IcoTextStyle
                                                  .boldTextStyle15B),
                                          TextSpan(
                                              text:
                                                  ' ${voucherController.maxWeekSupported.value}주차',
                                              style: IcoTextStyle
                                                  .boldTextStyle15P),
                                          TextSpan(
                                              text: '까지만 적용됩니다.',
                                              style: IcoTextStyle
                                                  .boldTextStyle15B),
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
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
                          "사용하실 서비스 유형을 모두 선택하시면 요금이 표시됩니다.",
                          style: IcoTextStyle.mediumTextStyle15Grey4,
                        ),
                      ),
              ],
            ),
          );
        }));
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
