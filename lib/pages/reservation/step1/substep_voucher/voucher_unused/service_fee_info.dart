import 'dart:io';

import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/steps.dart';
import 'package:app/configs/table_contents.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/address_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed2.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/info_box/cost_info_box.dart';
import 'package:app/widgets/divider/mydivider.dart';
import 'package:app/widgets/dropdown/voucher_dropdown.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../widgets/loading/loading.dart';
import '../../../step3/deposit_fee_status.dart';

class ServiceFeeInfoPage extends StatelessWidget {
  ServiceFeeInfoPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  AddressController _addressController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: IcoColors.white,
        appBar: IcoAppbar(
          hasShadow: false,
          iconColor: IcoColors.white,
          backgroundColor: IcoColors.primary,
          title: "μκΈν",
          usePop: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
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
                        "μΌλ° μλΉμ€ μκΈ μλ΄",
                        style: IcoTextStyle.boldTextStyle24W,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "μ λΆμ§μκΈ λ―Έμ΄μ©μ μΌλ° μλΉμ€ μκΈμλλ€",
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
                        "μΌλ° μλΉμ€ μκΈ μλ΄",
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
                        "*κΈ°λ³ΈμκΈμ λ³΄κ±΄λ³΅μ§λΆ κ·μ μ λ°λΌ μ±μ λμμ΅λλ€.",
                        style: IcoTextStyle.mediumTextStyle12B,
                      ),
                      SizedBox(
                        height: 56,
                      ),
                      Text(
                        "μμ½κΈ μλ΄",
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
                        "* μμ½ ν 3μΌ λ΄μ μμ½κΈμ μκΈνμλ©΄ μμ½μ΄ μλ£λ©λλ€.\n* μμ½κΈμ νκΈ μκΈμ΄ μμΉμλλ€.",
                        style: IcoTextStyle.mediumTextStyle12B,
                      ),
                      SizedBox(
                        height: 56,
                      ),
                      Text(
                        "μΆκ°μκΈμλ΄",
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
                        "* μ°λͺ¨λμ μ¬κ±΄μ λ§μΆμ΄, κ΄λ¦¬μ¬λκ³Ό νμνμ μΆκ°μκΈ κ΄λ ¨ μλΉμ€λ₯Ό μ΄μ©ν  μ μμ΅λλ€.\n** μ¬νκ·Όλ¬΄ λ±μΌλ‘ μμ£Όνλ λ°°μ°μμκ² νν©λλ€.",
                        style: IcoTextStyle.mediumTextStyle12B,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      IcoButton(
                          icon: false,
                          onPressed: () async {
                            // await authController.createReservationFirestore(
                            //     authController.userModel.value!,
                            //     _addressController.completeAddress.value!,
                            //     null,
                            //     2,
                            //     'μΌλ°μλΉμ€');
                            // await authController.setModelInfo();
                            // Get.offAllNamed(Routes.HOME);
                            Get.toNamed(Routes.VOUCHER_UNSIGNED_NORMAL,
                                arguments: {'command': ''});
                          },
                          active: true.obs,
                          buttonColor: IcoColors.primary,
                          textStyle: IcoTextStyle.buttonTextStyleW,
                          text: "μΌλ°μλΉμ€ μ μ²­"),
                      Container(
                        margin: Platform.isAndroid
                            ? const EdgeInsets.only(bottom: 20)
                            : null,
                        child: Center(
                          child: UnderlinedTextButton(
                              onTap: () async {
                                await authController.setModelInfo();
                                Get.offAllNamed(Routes.HOME);
                              },
                              text: 'λ©μΈνλ©΄μΌλ‘ μ΄λ'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
