import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/steps.dart';
import 'package:app/configs/table_contents.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/reservation/step1/voucher_controller.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed2.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/cost_info_box.dart';
import 'package:app/widgets/divider/mydivider.dart';
import 'package:app/widgets/dropdown/voucher_dropdown.dart';
import 'package:app/widgets/appbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../loading.dart';

class ServiceFeeInfoPage extends StatelessWidget {
  ServiceFeeInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoucherController voucherController = Get.put(VoucherController());

    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          isDefault: false,
          iconColor: IcoColors.white,
          backgroundColor: IcoColors.primary,
          title: "요금표",
          usePop: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: IcoSize.width,
                color: IcoColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "일반 서비스 요금 안내",
                      style: IcoTextStyle.boldTextStyle24W,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "정부지원금 미이용시 일반 서비스 요금입니다",
                      style: IcoTextStyle.mediumTextStyle13W,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Container(
                width: IcoSize.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "일반 서비스 요금 안내",
                      style: IcoTextStyle.boldTextStyle19B,
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    IcoDataTable(
                        colorList: TableColorListPurple,
                        list1: serviceFeeList1,
                        list2: serviceFeeList2,
                        list3: serviceFeeList3),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "*기본요금은 보건복지부 규정을 따라 책정되었습니다.",
                      style: IcoTextStyle.mediumTextStyle12B,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Text(
                      "예약금 안내",
                      style: IcoTextStyle.boldTextStyle19B,
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    IcoDataTable2(
                      colorList: TableColorListYellow,
                      list1: depositFeeList1,
                      list2: depositFeeList2,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "* 예약 후 3일 내에 예약금을 입금하시면 예약이 완료됩니다.\n* 예약금은 현금 입금이 원칙입니다.",
                      style: IcoTextStyle.mediumTextStyle12B,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Text(
                      "추가요금안내",
                      style: IcoTextStyle.boldTextStyle19B,
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    IcoDataTable3(
                      colorList: TableColorListPurple,
                      list1: extraFeeList1,
                      list2: extraFeeList2,
                      spanList: extraFeeSpanList,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "* 산모님의 여건에 맞추어, 관리사님과 협의하에 추가요금 관련 서비스를 이용할 수 있습니다.\n** 재택근무 등으로 상주하는 배우자에게 한합니다.",
                      style: IcoTextStyle.mediumTextStyle12B,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    IcoButton(
                        icon: false,
                        onPressed: () async {
                          AuthController authController = Get.find();
                          await authController.setModelInfo();
                          Get.offAllNamed(Routes.HOME);
                        },
                        active: true.obs,
                        buttonColor: IcoColors.primary,
                        textStyle: IcoTextStyle.buttonTextStyleW,
                        text: "일반서비스 신청"),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          AuthController authController = Get.find();
                          await authController.setModelInfo();
                          Get.offAllNamed(Routes.HOME);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "메인화면으로 이동",
                            style: IcoTextStyle.mediumLinedTextStyle14G,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class IcoDataTable extends StatelessWidget {
  const IcoDataTable({
    Key? key,
    required this.colorList,
    required this.list1,
    required this.list2,
    required this.list3,
  }) : super(key: key);

  final List<Color> colorList;
  final List<String> list1;
  final List<String> list2;
  final List<String> list3;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: Container(
          height: 43 * 5,
          width: double.infinity,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 43,
                          color: colorList[index],
                          child: Text(
                            "${list1[index]}",
                            style: (index == 0)
                                ? IcoTextStyle.boldTextStyle13B
                                : IcoTextStyle.mediumTextStyle13B,
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        lineLength: 43,
                        lineThickness: 1.0,
                        dashLength: 4.5,
                        dashColor: IcoColors.grey3,
                        dashGapLength: 4.0,
                        dashGapColor: colorList[index],
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          height: 43,
                          color: colorList[index],
                          child: Text(
                            "${list2[index]}",
                            style: (index == 0)
                                ? IcoTextStyle.boldTextStyle13B
                                : IcoTextStyle.mediumTextStyle13B,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          height: 43,
                          color: colorList[index],
                          child: Text(
                            "${list3[index]}",
                            style: (index == 0)
                                ? IcoTextStyle.boldTextStyle13B
                                : IcoTextStyle.mediumTextStyle13B,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}

class IcoDataTable2 extends StatelessWidget {
  const IcoDataTable2({
    Key? key,
    required this.colorList,
    required this.list1,
    required this.list2,
  }) : super(key: key);

  final List<Color> colorList;
  final List<String> list1;
  final List<String> list2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: Container(
          height: 43 * 5,
          width: double.infinity,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 43,
                          color: colorList[index],
                          child: Text(
                            "${list1[index]}",
                            style: (index == 0)
                                ? IcoTextStyle.boldTextStyle13B
                                : IcoTextStyle.mediumTextStyle13B,
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        lineLength: 43,
                        lineThickness: 1.0,
                        dashLength: 4.5,
                        dashColor: IcoColors.grey3,
                        dashGapLength: 4.0,
                        dashGapColor: colorList[index],
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.center,
                          height: 43,
                          color: colorList[index],
                          child: Text(
                            "${list2[index]}",
                            style: (index == 0)
                                ? IcoTextStyle.boldTextStyle13B
                                : IcoTextStyle.mediumTextStyle13B,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}

class IcoDataTable3 extends StatelessWidget {
  const IcoDataTable3({
    Key? key,
    required this.colorList,
    required this.list1,
    required this.list2,
    required this.spanList,
  }) : super(key: key);

  final List<Color> colorList;
  final List<String> list1;
  final List<String> list2;
  final List<String> spanList;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: Container(
          height: 43 * 9,
          width: double.infinity,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: (index == 0)
                              ? EdgeInsets.only(left: 0)
                              : EdgeInsets.only(left: 20),
                          alignment: (index == 0)
                              ? Alignment.center
                              : Alignment.centerLeft,
                          height: 43,
                          color: colorList[index],
                          child: Text.rich(
                            TextSpan(
                              text: "${list1[index]}",
                              style: IcoTextStyle.boldTextStyle13B,
                              children: <TextSpan>[
                                TextSpan(
                                    text: "  ${spanList[index]}",
                                    style: IcoTextStyle.mediumTextStyle12P),
                              ],
                            ),
                          ),
                        ),
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        lineLength: 43,
                        lineThickness: 1.0,
                        dashLength: 4.5,
                        dashColor: IcoColors.grey3,
                        dashGapLength: 4.0,
                        dashGapColor: colorList[index],
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: 43,
                          color: colorList[index],
                          child: Text(
                            "${list2[index]}",
                            style: (index == 0)
                                ? IcoTextStyle.boldTextStyle13B
                                : IcoTextStyle.mediumTextStyle13B,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
