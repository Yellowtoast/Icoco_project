import 'dart:async';

import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/password_controller.dart';

import 'package:app/controllers/signup_controller.dart';
import 'package:app/helpers/formatter.dart';

import 'package:app/helpers/validator.dart';
import 'package:app/pages/find_password/find_password2.dart';

import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/textfield/regnum_textfield.dart';
import 'package:app/widgets/textfield/textfield.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPasswordPage1 extends StatelessWidget {
  FindPasswordPage1({Key? key}) : super(key: key);
  PasswordController passwordController = Get.put(PasswordController());
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    passwordController.errorTextList = [
      passwordController.nameErrorText,
      passwordController.regNumErrorText,
      passwordController.phoneErrorText,
      passwordController.authCodeErrorText
    ].obs;

    passwordController.controllerList = [
      passwordController.nameController,
      passwordController.birthController,
      passwordController.genderController,
      passwordController.phoneController,
      passwordController.authCodeController
    ].obs;

    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: IcoAppbar(
            title: '비밀번호 찾기',
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
                      '비밀번호 찾기',
                      style: IcoTextStyle.boldTextStyle24B,
                    ),
                  ),
                  SizedBox(
                    height: 21,
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
                          width: IcoSize.width,
                          hintText: "본인 명의 이름을 입력해주세요",
                          textFieldLabel: "본명",
                          errorText: passwordController.nameErrorText,
                          myTextController: passwordController.nameController,
                          onChanged: (value) {
                            validateName(
                                value, passwordController.nameErrorText);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IcoRegNumField(
                          frontHintText: "주민번호 앞자리",
                          textFieldLabel: "생년월일",
                          frontTextController:
                              passwordController.birthController,
                          backTextController:
                              passwordController.genderController,
                          onChanged: (value) {
                            validateRegNum(
                                passwordController.birthController.value.text,
                                passwordController.genderController.value.text,
                                passwordController.regNumErrorText);
                          },
                          backHintText: '',
                          errorText: passwordController.regNumErrorText,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            IcoTextFormField(
                              width: IcoSize.width - 40 - 106 - 8,
                              maxLength: 13,
                              hintText: "-없이 입력해주세요",
                              textFieldLabel: "전화번호",
                              errorText: passwordController.phoneErrorText,
                              myTextController:
                                  passwordController.phoneController,
                              textInputFormatter: [
                                PhoneNumberTextInputFormatter()
                              ],
                              onChanged: (value) {
                                validatePhoneNumber(
                                    value,
                                    passwordController.codeSendButtonValid,
                                    passwordController.phoneErrorText);
                                if (value != '') {
                                  passwordController.phoneNumber =
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
                                onPressed: () {
                                  passwordController.codeSendButtonValid.value =
                                      false;
                                  passwordController.startAuthCodeTimer(180);
                                  passwordController.sendAuthCodeMessage();
                                },
                                active: passwordController.codeSendButtonValid,
                                textStyle: IcoTextStyle.boldTextStyle14W,
                                text:
                                    (passwordController.codeSentTimes.value > 0)
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
                              width: IcoSize.width,
                              maxLength: 5,
                              hintText: "메시지로 전송된 번호를 입력해주세요",
                              textFieldLabel: "인증번호",
                              errorText: passwordController.authCodeErrorText,
                              myTextController:
                                  passwordController.authCodeController,
                              onChanged: (value) {
                                passwordController.validateAuthCode();
                              },
                            ),
                            (passwordController
                                    .showTimer.value)
                                ? Positioned(
                                    right: 20,
                                    bottom: 40,
                                    child: Text(
                                        (passwordController.codeSendButtonValid
                                                        .value ==
                                                    true &&
                                                passwordController
                                                        .timeLeft.value <=
                                                    0)
                                            ? '기한만료'
                                            : (passwordController
                                                            .timeLeft.value ~/
                                                        60)
                                                    .toString() +
                                                ":" +
                                                (((passwordController.timeLeft
                                                                    .value %
                                                                60) <
                                                            10)
                                                        ? '0' +
                                                            (passwordController
                                                                        .timeLeft
                                                                        .value %
                                                                    60)
                                                                .toString()
                                                        : passwordController
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
                              passwordController.uid =
                                  await passwordController.checkUserFirestore(
                                      passwordController.nameController.text,
                                      passwordController.phoneController.text,
                                      passwordController.getRegnum());

                              print(passwordController.uid);

                              if (passwordController.uid == null) {
                                passwordController.phoneErrorText.value =
                                    '정보가 일치하는 회원이 없습니다.';
                              } else {
                                Get.to(FindPasswordPage2());
                              }
                            },
                            active: passwordController.isButtonValid,
                            buttonColor: IcoColors.primary,
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
        ),
      );
    });
  }
}
