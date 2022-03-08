import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/voucher_controller.dart';
import 'package:app/helpers/validator.dart';
import 'package:app/pages/reservation/step1/substep_voucher/voucher_signed/voucher_signed3.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/textfield/regnum_textfield.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VoucherSignedStep2 extends StatefulWidget {
  const VoucherSignedStep2({Key? key}) : super(key: key);

  @override
  _VoucherSignedStep2State createState() => _VoucherSignedStep2State();
}

class _VoucherSignedStep2State extends State<VoucherSignedStep2> {
  VoucherController voucherController = Get.find();

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: IcoAppbar(title: '주민번호 입력'),
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 27,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '산모님의 주민등록번호를\n입력해주세요',
                          style: IcoTextStyle.boldTextStyle24B,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "주민번호는 바우처 등록 이외 사용하지 않습니다.\n바우처 연동 후 페기됩니다.",
                    style: IcoTextStyle.mediumTextStyle13Grey4,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IcoTextFormField(
                            width: (IcoSize.width - 40 - 28) / 2,
                            hintText: "앞자리 6자리",
                            maxLength: 6,
                            textFieldLabel: "",
                            keyboardType: TextInputType.number,
                            errorText: voucherController.regNumErrorText,
                            myTextController:
                                voucherController.frontRegNumController,
                            showErrorText: false,
                            onChanged: (value) {
                              validateFullRegNum(
                                  voucherController
                                      .frontRegNumController.value.text,
                                  voucherController
                                      .backRegNumController.value.text,
                                  voucherController.regNumErrorText);
                              voucherController.validateButton(
                                  voucherController
                                      .frontRegNumController.value.text,
                                  voucherController
                                      .backRegNumController.value.text);
                            },
                          ),
                          SizedBox(
                            width: 28,
                            child: SvgPicture.asset("icons/line.svg"),
                          ),
                          IcoTextFormField(
                            width: (IcoSize.width - 40 - 28) / 2,
                            hintText: "뒷자리 7자리",
                            keyboardType: TextInputType.number,
                            textFieldLabel: "",
                            maxLength: 7,
                            errorText: voucherController.regNumErrorText,
                            showErrorText: false,
                            myTextController:
                                voucherController.backRegNumController,
                            onChanged: (value) async {
                              await validateFullRegNum(
                                  voucherController
                                      .frontRegNumController.value.text,
                                  voucherController
                                      .backRegNumController.value.text,
                                  voucherController.regNumErrorText);
                              voucherController.validateButton(
                                  voucherController
                                      .frontRegNumController.value.text,
                                  voucherController
                                      .backRegNumController.value.text);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IcoButton(
                              onPressed: () {
                                // voucherController.updateRegnumToModel(
                                //     authController.reservationModel);
                                Get.toNamed(Routes.VOUCHER_SIGNED3);
                              },
                              active: voucherController.isButtonValid,
                              buttonColor: IcoColors.primary,
                              textStyle: IcoTextStyle.buttonTextStyleW,
                              text: "다음으로"),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: IcoColors.grey3),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await authController.setModelInfo();
                                Get.offAllNamed(Routes.HOME);
                              },
                              child: Text(
                                "메인화면으로 이동",
                                style: IcoTextStyle.mediumLinedTextStyle14G,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
