import 'package:app/configs/colors.dart';
import 'package:app/configs/formats.dart';

import 'package:app/controllers/auth_controller.dart';

import 'package:app/controllers/refund_controller.dart';

import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';

import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/modal/option_modal.dart';

class RefundPage extends StatelessWidget {
  RefundPage({Key? key}) : super(key: key);

  AuthController authController = Get.find();
  RefundController refundController = Get.put(RefundController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: "서비스 환불",
        tapFunction: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 8),
                Container(
                  height: 83,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: IcoColors.grey1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${authController.reservationModel.value!.userName} 산모님의',
                            style: IcoTextStyle.regularTextStyle14B,
                          ),
                          Text(
                            '산후도우미 바우처 잔여일',
                            style: IcoTextStyle.boldTextStyle14B,
                          )
                        ],
                      ),
                      Text(
                        '${refundController.serviceDaysLeft}일',
                        style: IcoTextStyle.boldTextStyle35P,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 174,
                  decoration: BoxDecoration(
                      color: IcoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: IcoColors.grey2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '서비스 예약 취소 시 환불되는 본인부담금',
                                style: IcoTextStyle.boldTextStyle14P,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '신청 ${refundController.serviceDays}일 (${authController.reservationModel.value!.serviceDuration})',
                                    style: IcoTextStyle.mediumTextStyle13Grey4,
                                  ),
                                  Text(
                                    '${decimalFormat.format(authController.reservationModel.value!.userCost)} 원',
                                    style: IcoTextStyle.mediumTextStyle16B,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '이용 ${refundController.serviceDaysSpent}일 (${refundController.spentUserFeePercent}%)',
                                    style: IcoTextStyle.mediumTextStyle13Grey4,
                                  ),
                                  Text(
                                    '${decimalFormat.format(refundController.spentUserFee)} 원',
                                    style: IcoTextStyle.mediumTextStyle16B,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 57,
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        decoration: BoxDecoration(
                            color: IcoColors.purple2,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '잔여 ${refundController.serviceDaysLeft}일 (${refundController.refundableFeePercent}%)',
                              style: IcoTextStyle.boldTextStyle14B,
                            ),
                            Text(
                              '${decimalFormat.format(refundController.refundableUserFee)} 원',
                              style: IcoTextStyle.boldTextStyle18P,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 350,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: IcoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: IcoColors.grey2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '환불계좌 입력',
                        style: IcoTextStyle.boldTextStyle14P,
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        '입금은행',
                        style: IcoTextStyle.boldTextStyle13B,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonWidth: double.infinity,
                          buttonHeight: 50,
                          buttonPadding: EdgeInsets.all(10),
                          buttonDecoration: BoxDecoration(
                              color: IcoColors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: IcoColors.grey2,
                                width: 1,
                              )),
                          style: IcoTextStyle.mediumTextStyle15B,
                          value: refundController.bankSelected.value,
                          icon: SvgPicture.asset("icons/dropdown_arrow.svg"),
                          hint: Text(
                            '입금은행 선택',
                            style: IcoTextStyle.mediumTextStyle15Grey4,
                          ),
                          items: refundController.bankType.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (item) {
                            refundController.bankSelected.value =
                                item.toString();
                            (refundController.bankSelected.value != null)
                                ? refundController.stepList[0] = true.obs
                                : refundController.stepList[0] = false.obs;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '계좌번호',
                        style: IcoTextStyle.boldTextStyle13B,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      IcoTextField(
                        textController:
                            refundController.accountNumberTextController,
                        textInputType: TextInputType.number,
                        width: double.infinity,
                        hintText: '숫자만 입력',
                        onChanged: (value) {
                          refundController.accountNumber.value = value;
                          (value != '')
                              ? refundController.stepList[1] = true.obs
                              : refundController.stepList[1] = false.obs;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '예금주명',
                        style: IcoTextStyle.boldTextStyle13B,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      IcoTextField(
                        textController:
                            refundController.accountHolderTextController,
                        textInputType: TextInputType.text,
                        width: double.infinity,
                        onChanged: (value) {
                          refundController.accountHolder.value = value;
                          (value != '')
                              ? refundController.stepList[2] = true.obs
                              : refundController.stepList[2] = false.obs;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: IcoColors.grey1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "본인부담금 환불에는 1~3일 정도가 소요됩니다",
                    style: IcoTextStyle.boldTextStyle13P,
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                IcoButton(
                    onPressed: () async {
                      bool confirm = await IcoOptionModal(
                          iconUrl: 'icons/refund.svg',
                          title: "본인부담금 환불에는\n1~3일 정도 소요됩니다",
                          subtitle: '일반적으로 환불에는 약 1~3일\n소요됩니다. 환불을 진행하시겠습니까?',
                          option1: '아니오',
                          option2: '환불신청');

                      if (confirm) {
                        refundController.createRefundFirestore(authController
                            .reservationModel.value!.reservationNumber);
                        Get.offNamed(Routes.HOME);
                      }
                    },
                    active: refundController.isButtonValid,
                    buttonColor: IcoColors.primary,
                    textStyle: IcoTextStyle.buttonTextStyleW,
                    text: '환불 신청하기'),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class IcoTextField extends StatelessWidget {
  IcoTextField({
    Key? key,
    required this.textInputType,
    required this.textController,
    required this.onChanged,
    required this.width,
    this.hintText = '',
    this.height = 50,
  }) : super(key: key);

  TextInputType textInputType;
  TextEditingController textController;

  double width;
  double height;
  String hintText;
  void Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: IcoColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: IcoColors.grey2)),
      child: TextField(
        keyboardType: textInputType,
        controller: textController,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: IcoTextStyle.mediumTextStyle16Grey3,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
