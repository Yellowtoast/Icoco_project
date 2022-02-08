import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/reservation/step1/address_controller.dart';
import 'package:app/pages/reservation/step1/substep_address/address1.dart';
import 'package:app/pages/reservation/step1/substep_address/address2.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed1.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/modal/bottomup_modal.dart';
import 'package:app/widgets/modal/modal.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'voucher_unused/service_fee_info.dart';

class VoucherStep1 extends StatelessWidget {
  const VoucherStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddressController addressController = Get.find();
    return Scaffold(
        appBar: IcoAppbar(
          title: "요금 계산",
          usePop: true,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 31,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "잠깐,\n정부지원금 신청은 하셨나요?",
                  style: IcoTextStyle.boldTextStyle27B,
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  "산후도우미 서비스는 출산 장려 정책으로\n정부지원금 혜택을 받을 수 있는 서비스입니다.\n산모님의 조건에 맞는 등급유형을 배정받으신 후\n아이코코의 서비스를 이용해 주세요.",
                  style: IcoTextStyle.mediumTextStyle14B,
                ),
                SizedBox(
                  height: 41,
                ),
                Expanded(
                  child: Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          return IcoButton(
                              iconColor: IcoColors.primary,
                              icon: false,
                              border: true,
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Obx(() {
                                      return BottomUpModal(
                                        address:
                                            addressController.address.value!,
                                      );
                                    });
                                  },
                                );
                              },
                              active: true.obs,
                              buttonColor: IcoColors.white,
                              textStyle: IcoTextStyle.buttonTextStyleP,
                              text: "신청하지 않았습니다");
                        }),
                        SizedBox(
                          height: 17,
                        ),
                        IcoButton(
                            icon: false,
                            iconColor: IcoColors.white,
                            onPressed: () {
                              Get.toNamed(Routes.VOUCHER_SIGNED1,
                                  arguments: {'command': ''});
                            },
                            active: true.obs,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "신청했습니다"),
                        SizedBox(
                          height: 17,
                        ),
                        IcoButton(
                            icon: false,
                            iconColor: IcoColors.white,
                            onPressed: () {
                              Get.to(ServiceFeeInfoPage());
                            },
                            active: true.obs,
                            buttonColor: IcoColors.grey4,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "정부지원금을 이용하지 않습니다"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
