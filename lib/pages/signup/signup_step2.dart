import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/signup_controller.dart';
import 'package:app/helpers/validator.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupStep2Page extends StatelessWidget {
  SignupStep2Page({Key? key}) : super(key: key);
  // AuthController authController =   Get.find<AuthController>(tag: "HOME_CONTROL1");
  SignupController signupController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEmailExist = false;

  @override
  Widget build(BuildContext context) {
    signupController.errorTextList = [
      signupController.emailErrorText,
      signupController.passwordErrorText,
      signupController.confirmPasswordErrorText
    ].obs;

    signupController.controllerList = [
      signupController.emailController,
      signupController.passwordController,
      signupController.confirmPasswordController,
    ].obs;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: IcoAppbar(title: '회원가입'),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: IcoSize.height - 330,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 27,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '기본정보입력',
                              style: IcoTextStyle.boldTextStyle24B,
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: IcoColors.purple1,
                              ),
                              width: 57,
                              height: 31,
                              child: Text("2/3",
                                  style: GoogleFonts.notoSans(
                                      fontSize: 13,
                                      color: IcoColors.primary,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IcoTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                width: double.infinity,
                                hintText: "이메일을 입력하세요",
                                textFieldLabel: "이메일",
                                errorText: signupController.emailErrorText,
                                myTextController:
                                    signupController.emailController,
                                onChanged: (value) async {
                                  await signupController.checkDuplicateUser();
                                  validateEmail(
                                      value,
                                      signupController.emailErrorText,
                                      signupController.isDuplicateEmail);
                                },
                              ),
                              IcoTextFormField(
                                keyboardType: TextInputType.text,
                                width: double.infinity,
                                obscureText: true,
                                hintText: "8~12자 / 영문숫자조합",
                                textFieldLabel: "비밀번호",
                                errorText: signupController.passwordErrorText,
                                myTextController:
                                    signupController.passwordController,
                                onChanged: (value) async {
                                  validatePassword(
                                      value,
                                      signupController.passwordErrorText,
                                      false.obs);
                                },
                              ),
                              IcoTextFormField(
                                keyboardType: TextInputType.text,
                                width: double.infinity,
                                obscureText: true,
                                hintText: "8~12자 / 영문숫자조합",
                                textFieldLabel: "비밀번호 확인",
                                errorText:
                                    signupController.confirmPasswordErrorText,
                                myTextController:
                                    signupController.confirmPasswordController,
                                onChanged: (value) {
                                  validateConfirmPassword(
                                      signupController
                                          .passwordController.value.text,
                                      value,
                                      signupController.confirmPasswordErrorText,
                                      false.obs);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: IcoSize.height -
                        IcoSize.appbarHeight -
                        (IcoSize.height - 330),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        IcoButton(
                            onPressed: () async {
                              signupController.eventAlarm.value =
                                  await IcoOptionModal();
                              signupController.isButtonValid.value = false;
                              Get.toNamed(
                                Routes.SIGNUP_STEP3,
                              );
                            },
                            active: signupController.isButtonValid,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "다음으로"),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
