import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/additional_fee_controller.dart';
import 'package:app/configs/enum.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/date_info_controller.dart';
import 'package:app/controllers/reservation/step2/substep_controllers/service_info_controller.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/button/radio_button/text_radio_button.dart';
import 'package:app/widgets/modal/result_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReserveStep2_5 extends StatelessWidget {
  ReserveStep2_5({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  VoucherController voucherController = Get.find();
  AdditionalFeeController additionalFeeController =
      Get.put(AdditionalFeeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(title: '예약하기'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 27,
                    ),
                    Text(
                      '정부지원\n산후도우미 추가요금 계산',
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "추가적인 케어가 필요한 가족이 있는 경우,\n추가요금이 발생하게 됩니다.",
                      style: IcoTextStyle.mediumTextStyle13Grey4,
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    IcoButton(
                        icon: true,
                        border: false,
                        height: 45,
                        textAlign: MainAxisAlignment.start,
                        iconColor: IcoColors.grey3,
                        onPressed: () async {},
                        active: true.obs,
                        buttonColor: IcoColors.grey1,
                        textStyle: IcoTextStyle.mediumTextStyle13B,
                        text: "일일 요금 안내표 확인하기"),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("케어 형태", style: IcoTextStyle.boldTextStyle15B),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "도우미의 입주여부를 선택해주세요",
                          style: IcoTextStyle.mediumTextStyle13Grey4,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          children: [
                            TextRadioButton(
                              item: careType.COMMUTER,
                              itemTitle: "출퇴근형",
                              selectedItem:
                                  additionalFeeController.careTypeSelected,
                              onTap: () {
                                additionalFeeController.careTypeSelected.value =
                                    careType.COMMUTER;
                              },
                              activeBorderColor: IcoColors.primary,
                              inactiveBorderColor: IcoColors.grey2,
                            ),
                            SizedBox(width: 7),
                            TextRadioButton(
                              item: careType.RESIDENT,
                              itemTitle: "입주형",
                              selectedItem:
                                  additionalFeeController.careTypeSelected,
                              onTap: () {
                                additionalFeeController.careTypeSelected.value =
                                    careType.RESIDENT;
                              },
                              activeBorderColor: IcoColors.primary,
                              inactiveBorderColor: IcoColors.grey2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("자녀", style: IcoTextStyle.boldTextStyle15B),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "등하원서비스, 간단한 식사제공 및 빨래 등이 포함됩니다",
                      style: IcoTextStyle.mediumTextStyle13Grey4,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text("미취학 아동", style: IcoTextStyle.boldTextStyle13B),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: IcoColors.grey2,
                            width: 1,
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller:
                                  additionalFeeController.preschoolerController,
                              maxLength: 3,
                              style: IcoTextStyle.mediumTextStyle16B,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: "숫자 입력",
                                  hintStyle:
                                      IcoTextStyle.mediumTextStyle16Grey3),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text("명",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.mediumTextStyle16B)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text("유치원/어린이집", style: IcoTextStyle.boldTextStyle13B),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: IcoColors.grey2,
                            width: 1,
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: additionalFeeController
                                  .kindergartenController,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              style: IcoTextStyle.mediumTextStyle16B,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: "숫자 입력",
                                  hintStyle:
                                      IcoTextStyle.mediumTextStyle16Grey3),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text("명",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.mediumTextStyle16B)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text("초등생 이상", style: IcoTextStyle.boldTextStyle13B),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: IcoColors.grey2,
                            width: 1,
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller:
                                  additionalFeeController.schoolerController,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              style: IcoTextStyle.mediumTextStyle16B,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: "숫자 입력",
                                  hintStyle:
                                      IcoTextStyle.mediumTextStyle16Grey3),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text("명",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.mediumTextStyle16B)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              DividerLineWidget(),
              SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("기타가족", style: IcoTextStyle.boldTextStyle15B),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "남편 및 상주인원 포함\n간단한 식사제공 및 빨래 등이 포함됩니다.",
                      style: IcoTextStyle.mediumTextStyle13Grey4,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: IcoColors.grey2,
                            width: 1,
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller:
                                  additionalFeeController.extraFamilyController,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              style: IcoTextStyle.mediumTextStyle16B,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: "숫자 입력",
                                  hintStyle:
                                      IcoTextStyle.mediumTextStyle16Grey3),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text("명",
                                  textAlign: TextAlign.right,
                                  style: IcoTextStyle.mediumTextStyle16B)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 59,
                    ),
                    IcoButton(
                        onPressed: () {
                          additionalFeeController.setExtraChargeOptions();
                          BottomResultModal();
                        },
                        active: additionalFeeController.isButtonValid,
                        textStyle: IcoTextStyle.buttonTextStyleW,
                        text: "다음으로"),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
