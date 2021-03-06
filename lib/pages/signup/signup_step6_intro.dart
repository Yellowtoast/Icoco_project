import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/steps.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/intro_page_controller.dart';
import 'package:app/controllers/signup_controller.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/loading/loading.dart';

class SignupStep6Page extends StatelessWidget {
  SignupStep6Page({Key? key}) : super(key: key);
  Rx<int> pageIndex = 0.obs;
  SignupController signupController = Get.find();
  AuthController authController = Get.find();
  PageController pageController = PageController(
    initialPage: 0,
  );

  List<Color> backgroundColorSet = [
    IcoColors.purple2,
    IcoColors.purple2,
    IcoColors.purple2,
    IcoColors.white
  ];

  IntroPageController _introPageController = Get.put(IntroPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor:
              (pageIndex.value == 3) ? IcoColors.white : IcoColors.purple2,
          appBar: PreferredSize(
            child: AppBar(
              centerTitle: true,
              leading: Container(
                padding: EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 25),
                    child: SvgPicture.asset(
                      "icons/arrow_back.svg",
                      color: IcoColors.grey4,
                    ),
                  ),
                ),
              ),
              elevation: 0.0,
              bottomOpacity: 0.0,
              backgroundColor: Colors.transparent,
              title: Container(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    spacing: 11.0,
                    radius: 10.0,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: IcoColors.grey2,
                    activeDotColor: IcoColors.primary,
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(Get.height * 0.063),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: PageView(
            onPageChanged: (page) {
              pageIndex.value = page;
            },
            controller: pageController,
            children: [
              SizedBox.expand(
                child: Container(
                  color: IcoColors.purple2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "????????? ???????????????\n",
                                style: IcoTextStyle.boldTextStyle27B,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '?????????',
                                      style: IcoTextStyle.boldTextStyle27B),
                                  TextSpan(
                                      text: ' ????????????!',
                                      style: IcoTextStyle.boldTextStyle27P),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "????????? ?????????????????? ??????????????? ??????\n???????????? ????????? ???????????? ???????????????",
                              style: IcoTextStyle.mediumTextStyle14B,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Image.asset(
                          "images/intro_1.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.expand(
                child: Container(
                  color: IcoColors.purple2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "????????? ??????????????????\n",
                                style: IcoTextStyle.boldTextStyle27B,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '???????????? ????????????!',
                                      style: IcoTextStyle.boldTextStyle27P),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "????????? ?????? ??????????????? ????????? ???????????????\n?????????????????? ???????????? ??????????????????",
                              style: IcoTextStyle.mediumTextStyle14B,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Image.asset(
                          "images/intro_2.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.expand(
                child: Container(
                  color: IcoColors.purple2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "?????? ????????????\n??????????????? ",
                                style: IcoTextStyle.boldTextStyle27B,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '??????&??????',
                                      style: IcoTextStyle.boldTextStyle27P),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "????????? ??????????????? ????????? ??????!\n?????? ????????????????????? ????????? ??????????????????",
                              style: IcoTextStyle.mediumTextStyle14B,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Image.asset(
                          "images/intro_3.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: SizedBox.expand(
                  child: Container(
                    color: IcoColors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "?????? ??????",
                                  style: IcoTextStyle.boldTextStyle27P,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '??? ?????????\n????????? ??????!',
                                        style: IcoTextStyle.boldTextStyle27B),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text.rich(
                                TextSpan(
                                  text:
                                      "????????? ??????????????? ?????? ????????????\n????????? ????????? ??? ?????? ????????????\n",
                                  style: IcoTextStyle.mediumTextStyle14B,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '?????? 5,000????????? ?????? 30,000?????? ????????????!',
                                        style: IcoTextStyle.boldTextStyle14B),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              // SizedBox(
                              //   height: 54,
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Image.asset(
                            "images/intro_4.png",
                            width: IcoSize.width - 140,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IcoButton(
                                    icon: false,
                                    onPressed: () async {
                                      String? reservationNumber;
                                      bool getReserveHistory = false;
                                      String? uid;
                                      authController.isLoggedIn.value = false;
                                      startLoadingIndicator();
                                      reservationNumber = await signupController
                                          .getExistingReservationNumber(
                                        signupController.nameController.text,
                                        signupController.phoneController.text,
                                      );

                                      if (reservationNumber != '') {
                                        getReserveHistory =
                                            await IcoOptionModal2();
                                      }
                                      uid = await signupController
                                          .registerWithEmailAndPassword(
                                              signupController
                                                  .emailController.text,
                                              signupController
                                                  .passwordController.text);

                                      if (getReserveHistory == true) {
                                        await authController
                                            .setPreviousReservation(
                                                reservationNumber!,
                                                uid!,
                                                signupController
                                                    .userModel.value!.email);
                                      }
                                      authController.isLoggedIn.value = true;
                                      await authController.setModelInfo();
                                      finishLoadingIndicator();
                                      Get.offAllNamed(Routes.HOME);
                                    },
                                    active: true.obs,
                                    buttonColor: IcoColors.primary,
                                    textStyle: IcoTextStyle.buttonTextStyleW,
                                    text: "???????????? ????????????"),
                                SizedBox(
                                  height: 20,
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
            ],
          ));
    });
  }
}
