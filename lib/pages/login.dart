import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/login_controller.dart';
import 'package:app/controllers/signup_controller.dart';
import 'package:app/helpers/validator.dart';
import 'package:app/pages/find_password1.dart';
import 'package:app/pages/loading.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  LoginController loginController = Get.find();
  AuthController authController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    loginController.errorTextList = [
      loginController.emailErrorText,
      loginController.passwordErrorText,
    ].obs;

    loginController.controllerList = [
      loginController.emailController,
      loginController.passwordController,
    ].obs;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: IcoAppbar(title: '로그인'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '아이코코 로그인하기',
                      style: IcoTextStyle.boldTextStyle24B,
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
                        width: double.infinity,
                        hintText: "이메일을 입력하세요",
                        textFieldLabel: "이메일",
                        errorText: loginController.emailErrorText,
                        myTextController: loginController.emailController,
                        onChanged: (value) {
                          validateEmail(
                              value, loginController.emailErrorText, false);
                        },
                      ),
                      IcoTextFormField(
                        width: double.infinity,
                        obscureText: true,
                        hintText: "8~12자 / 영문숫자조합",
                        textFieldLabel: "비밀번호",
                        errorText: loginController.passwordErrorText,
                        myTextController: loginController.passwordController,
                        onChanged: (value) {
                          validatePassword(value,
                              loginController.passwordErrorText, false.obs);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IcoButton(
                            onPressed: () async {
                              await loginController.login(
                                  authController.firebaseAuthUser,
                                  authController.isLoggedIn);
                            },
                            active: loginController.isButtonValid,
                            buttonColor: IcoColors.primary,
                            textStyle: IcoTextStyle.buttonTextStyleW,
                            text: "다음으로"),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(FindPasswordPage1());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "비밀번호 찾기",
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
      ),
    );
  }
}
