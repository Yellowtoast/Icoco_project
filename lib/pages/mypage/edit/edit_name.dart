import 'dart:async';

import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';

import 'package:app/controllers/signup_controller.dart';
import 'package:app/helpers/formatter.dart';

import 'package:app/helpers/validator.dart';

import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/textfield/regnum_textfield.dart';
import 'package:app/widgets/textfield/textfield.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/snackbar/snackbar.dart';

class EditNamePage extends StatelessWidget {
  EditNamePage({Key? key}) : super(key: key);
  SignupController signupController = Get.put(SignupController());
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    signupController.errorTextList = [
      signupController.nameErrorText,
      signupController.regNumErrorText,
      signupController.phoneErrorText,
      signupController.authCodeErrorText
    ].obs;

    signupController.controllerList = [
      signupController.nameController,
      signupController.birthController,
      signupController.genderController,
      signupController.phoneController,
      signupController.authCodeController
    ].obs;

    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: IcoAppbar(
            title: '회원정보 수정',
            usePop: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 27,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '이름 수정을 위해\n본인인증을 진행해주세요',
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: Get.width,
                    color: IcoColors.grey1,
                    height: 69,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "산모 본인의 명의로만 가입이 가능합니다\n본인 명의가 아닐 시 서비스 이용 제한이 있을 수 있습니다",
                          style: IcoTextStyle.mediumTextStyle13P,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IcoTextFormField(
                          keyboardType: TextInputType.text,
                          width: IcoSize.width,
                          hintText: "본인 명의 이름을 입력해주세요",
                          textFieldLabel: "본명",
                          errorText: signupController.nameErrorText,
                          myTextController: signupController.nameController,
                          onChanged: (value) {
                            validateName(value, signupController.nameErrorText);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IcoRegNumField(
                          frontHintText: "주민번호 앞자리",
                          textFieldLabel: "생년월일",
                          frontTextController: signupController.birthController,
                          backTextController: signupController.genderController,
                          onChanged: (value) {
                            validateRegNum(
                                signupController.birthController.value.text,
                                signupController.genderController.value.text,
                                signupController.regNumErrorText);
                          },
                          backHintText: '',
                          errorText: signupController.regNumErrorText,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            IcoTextFormField(
                              keyboardType: TextInputType.phone,
                              width: IcoSize.width - 40 - 106 - 8,
                              maxLength: 13,
                              hintText: "-없이 입력해주세요",
                              textFieldLabel: "전화번호",
                              errorText: signupController.phoneErrorText,
                              myTextController:
                                  signupController.phoneController,
                              textInputFormatter: [
                                PhoneNumberTextInputFormatter()
                              ],
                              onChanged: (value) {
                                validatePhoneNumber(
                                    value,
                                    signupController.codeSendButtonValid,
                                    signupController.phoneErrorText);
                                if (value != '') {
                                  signupController.phoneNumber =
                                      value.replaceAll('-', '');
                                }
                              },
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            IcoButton(
                                height: 50,
                                width: 106,
                                onPressed: () async {
                                  signupController.codeSendButtonValid.value =
                                      false;
                                  await signupController.sendAuthCodeMessage();
                                  openSnackbar(
                                      "인증번호 전송 완료", "전송된 인증번호를 입력해주세요");
                                  signupController.startAuthCodeTimer(180);
                                },
                                active: signupController.codeSendButtonValid,
                                textStyle: IcoTextStyle.boldTextStyle14W,
                                text: (signupController.codeSentTimes.value > 0)
                                    ? "재전송"
                                    : "인증번호 전송"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            IcoTextFormField(
                              keyboardType: TextInputType.number,
                              width: IcoSize.width,
                              maxLength: 5,
                              hintText: "메시지로 전송된 번호를 입력해주세요",
                              textFieldLabel: "인증번호",
                              errorText: signupController.authCodeErrorText,
                              myTextController:
                                  signupController.authCodeController,
                              onChanged: (value) {
                                signupController.validateAuthCode();
                              },
                            ),
                            (signupController.showTimer.value)
                                ? Positioned(
                                    right: 20,
                                    bottom: 40,
                                    child: Text(
                                        (signupController
                                                        .codeSendButtonValid.value ==
                                                    true &&
                                                signupController
                                                        .timeLeft.value <=
                                                    0)
                                            ? '기한만료'
                                            : (signupController
                                                            .timeLeft.value ~/
                                                        60)
                                                    .toString() +
                                                ":" +
                                                (((signupController.timeLeft
                                                                    .value %
                                                                60) <
                                                            10)
                                                        ? '0' +
                                                            (signupController
                                                                        .timeLeft
                                                                        .value %
                                                                    60)
                                                                .toString()
                                                        : signupController
                                                                .timeLeft
                                                                .value %
                                                            60)
                                                    .toString(),
                                        style: IcoTextStyle.mediumTextStyle14P))
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IcoButton(
                            onPressed: () async {
                              if (authController.reservationModel.value ==
                                  null) {
                                authController.userModel.value!.userName =
                                    signupController.nameController.text;
                                authController.updateUserFirestore(
                                    authController.userModel.value);
                              } else {
                                authController
                                        .reservationModel.value!.userName =
                                    signupController.nameController.text;
                                authController.userModel.value!.userName =
                                    signupController.nameController.text;
                                authController.updateUserFirestore(
                                    authController.userModel.value);
                                authController.updateReservationFirestore(
                                    authController.reservationModel.value!
                                        .reservationNumber);
                              }
                              await authController.setModelInfo();

                              Get.back();
                            },
                            active: signupController.isButtonValid,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "변경하기"),
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
        ),
      );
    });
  }
}
