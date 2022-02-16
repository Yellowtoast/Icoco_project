import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/steps.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/signup_controller.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/modal/option_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../loading.dart';

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
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "복잡한 산후도우미\n",
                              style: IcoTextStyle.boldTextStyle27B,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '신청을',
                                    style: IcoTextStyle.boldTextStyle27B),
                                TextSpan(
                                    text: ' 간편하게!',
                                    style: IcoTextStyle.boldTextStyle27P),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "어렵고 복잡하기만한 산후도우미 신청\n아이코코 앱으로 간편하게 신청하세요",
                            style: IcoTextStyle.mediumTextStyle14B,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Image.asset(
                        "images/intro_1.png",
                        width: IcoSize.width - 70,
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
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "간편한 요금계산기로\n",
                              style: IcoTextStyle.boldTextStyle27B,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '이용요금 알아보기!',
                                    style: IcoTextStyle.boldTextStyle27P),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "나에게 맞는 산후도우미 요금이 궁금하다면\n요금계산기로 간편하게 계산해보세요",
                            style: IcoTextStyle.mediumTextStyle14B,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Image.asset(
                        "images/intro_2.png",
                        width: IcoSize.width - 70,
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
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "미리 알아보는\n산후도우미 ",
                              style: IcoTextStyle.boldTextStyle27B,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '정보&후기',
                                    style: IcoTextStyle.boldTextStyle27P),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "복불복 산후도우미 배정은 그만!\n어떤 산후도우미인지 정보를 확인해보세요",
                            style: IcoTextStyle.mediumTextStyle14B,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Image.asset(
                        "images/intro_3.png",
                        width: IcoSize.width - 70,
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
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "이용 후기",
                                style: IcoTextStyle.boldTextStyle27P,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '만 남겨도\n선물이 펑펑!',
                                      style: IcoTextStyle.boldTextStyle27B),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "후기를 작성해주신 모든 산모님께\n상품과 교환할 수 있는 포인트를\n",
                                style: IcoTextStyle.mediumTextStyle14B,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '최소 5,000원에서 최대 30,000까지 드립니다!',
                                      style: IcoTextStyle.boldTextStyle14B),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 54,
                            ),
                            Image.asset(
                              "images/intro_4.png",
                              width: IcoSize.width - 140,
                            ),
                          ],
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
                                      Get.offAllNamed(Routes.HOME);
                                    },
                                    active: true.obs,
                                    buttonColor: IcoColors.primary,
                                    textStyle: IcoTextStyle.buttonTextStyleW,
                                    text: "아이코코 시작하기"),
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
