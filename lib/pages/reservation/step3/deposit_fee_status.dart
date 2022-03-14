import 'package:app/configs/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/home_controller.dart';

import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DepositFeeStatus extends StatelessWidget {
  DepositFeeStatus({Key? key}) : super(key: key);
  CompanyController companyController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: "입금 알리기",
        tapFunction: () {
          Get.offAllNamed(Routes.HOME);
        },
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 31,
                ),
                Text(
                  "예약금 입금처",
                  style: IcoTextStyle.boldTextStyle14B,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(17, 20, 17, 25),
                  decoration: BoxDecoration(
                      color: IcoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: IcoColors.grey2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 50, height: 50),
                                child: ElevatedButton(
                                  child: SvgPicture.asset(
                                      "icons/dear_care_logo.svg"),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: IcoColors.white,
                                    shape: CircleBorder(),
                                    side: BorderSide(color: IcoColors.grey2),
                                    shadowColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                companyController
                                    .companyModel.value!.companyName,
                                style: IcoTextStyle.boldTextStyle18B,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: IcoColors.grey1,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "은행",
                                        style: IcoTextStyle.boldTextStyle14B,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        companyController
                                            .companyModel.value!.bankName,
                                        style:
                                            IcoTextStyle.mediumTextStyle14Grey4,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "입금자명",
                                        style: IcoTextStyle.boldTextStyle14B,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        companyController.companyModel.value!
                                            .accountHolderName,
                                        style:
                                            IcoTextStyle.mediumTextStyle14Grey4,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "계좌번호",
                                        style: IcoTextStyle.boldTextStyle14B,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        companyController
                                            .companyModel.value!.accountNumber,
                                        style:
                                            IcoTextStyle.mediumTextStyle14Grey4,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 31,
                ),
                Text(
                  "상세내역",
                  style: IcoTextStyle.boldTextStyle14B,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(17, 20, 17, 25),
                  decoration: BoxDecoration(
                      color: IcoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: IcoColors.grey2)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "예약금",
                            style: IcoTextStyle.mediumTextStyle13P,
                          ),
                          Text(
                              "${numFormat.format(authController.reservationModel.value!.depositCost)} 원 미입금",
                              style: IcoTextStyle.boldTextStyle16P),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "잔금",
                            style: IcoTextStyle.mediumTextStyle13Grey4,
                          ),
                          Text(
                            "+ ${numFormat.format(authController.reservationModel.value!.balanceCost)} 원 미입금",
                            style: IcoTextStyle.mediumTextStyle16Grey4,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "총 본인부담금",
                            style: IcoTextStyle.mediumTextStyle13Grey4,
                          ),
                          Text(
                            "${numFormat.format(authController.reservationModel.value!.userCost)} 원 미입금",
                            style: IcoTextStyle.mediumTextStyle16Grey4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: IcoColors.grey1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: SvgPicture.asset("icons/info_mark.svg"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "예약금은 산후도우미 서비스 진행을 위해\n필수적으로 입금하셔야 합니다.",
                            style: IcoTextStyle.mediumTextStyle13P,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: SvgPicture.asset("icons/info_mark.svg"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "잔금은 이후 절차에 따라 입금하셔도 무방합니다.",
                            style: IcoTextStyle.mediumTextStyle13P,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 56,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IcoButton(
                        onPressed: () async {
                          await authController.updateSingleDataFirestore(
                              authController
                                  .reservationModel.value!.reservationNumber,
                              {'notifyDepositCost': true});

                          await authController.setModelInfo();
                          Get.offAllNamed(Routes.HOME);
                        },
                        active: (authController.reservationModel.value!
                                    .notifyDepositCost ==
                                true)
                            ? false.obs
                            : true.obs,
                        buttonColor: IcoColors.primary,
                        textStyle: IcoTextStyle.buttonTextStyleW,
                        text: (authController.reservationModel.value!
                                    .notifyDepositCost ==
                                true)
                            ? "예약금 입금을 확인중입니다"
                            : "예약금 입금 완료"),
                    UnderlinedTextButton(
                        onTap: () async {
                          await authController.setModelInfo();
                          Get.offAllNamed(Routes.HOME);
                        },
                        text: '메인화면으로 이동'),
                    // SizedBox(
                    //   height: 25,
                    // )
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class UnderlinedTextButton extends StatelessWidget {
  UnderlinedTextButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  void Function()? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: IcoColors.grey3),
          ),
        ),
        alignment: Alignment.bottomCenter,
        height: 30,
        width: 115,
        child: Text(
          text,
          style: IcoTextStyle.mediumLinedTextStyle14G,
        ),
      ),
    );
  }
}
