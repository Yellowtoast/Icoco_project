import 'package:app/configs/colors.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/intro_page_controller.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

PageController pageController = PageController(
  initialPage: 0,
);

class FeeGuidePages extends StatelessWidget {
  FeeGuidePages({Key? key}) : super(key: key);
  Rx<int> pageIndex = 0.obs;
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    IntroPageController introPageController = Get.put(IntroPageController());
    return Obx(() {
      return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
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
              (pageIndex.value == 2)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 31,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.bottomCenter,
                          child: IcoButton(
                              icon: false,
                              onPressed: () async {
                                authController = Get.find();
                                await authController.setModelInfo();
                                Get.offAllNamed(Routes.HOME);
                              },
                              active: true.obs,
                              buttonColor: IcoColors.primary,
                              textStyle: IcoTextStyle.buttonTextStyleW,
                              text: "??????"),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
          backgroundColor: IcoColors.white,
          appBar: IcoAppbar(
            title: "?????? ??????",
            tapFunction: () {
              AuthController authController = Get.find();
              authController.setModelInfo();
              Get.offAllNamed(Routes.HOME);
            },
            usePop: false,
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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 38,
                      ),
                      SvgPicture.asset("icons/money.svg"),
                      Column(
                        children: [
                          SizedBox(
                            height: 9,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "????????? ??????????????? ??????,\n???????????? ????????? ????????????!",
                              style: IcoTextStyle.boldTextStyle22B,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "???????????????, ???????????????, ???????????????\n????????? ??????????????? ?????? ????????? ??????????????????!",
                            style: IcoTextStyle.mediumTextStyle14B,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 29,
                      ),
                      Image.asset(
                        "images/fee_guide1.png",
                        width: IcoSize.width - 40,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: IcoColors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 27,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "?????? ????????? ??????",
                              style: IcoTextStyle.boldTextStyle22P,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '???\n????????? ?????????????????????',
                                    style: IcoTextStyle.boldTextStyle22B),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    GraphBoxWithDottedLine(
                      box1Color: IcoColors.yellow2,
                      box1Text: "????????????????????????",
                      box2Color: IcoColors.yellow1,
                      box2Text: "???????????????",
                      lineText: "?????? ????????? ??????",
                      box1TextStyle: IcoTextStyle.boldTextStyle15B,
                      box2TextStyle: IcoTextStyle.boldTextStyle15B,
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    ColorIndexBox(
                      contentText:
                          "??????????????? ???????????? ?????????????????? ??????\n?????? ???????????? ???????????? ??? ????????????.\n????????? ????????? ????????? ??? ???????????????!",
                      indexColor: IcoColors.yellow2,
                      indexText: '????????????????????????',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ColorIndexBox(
                      indexColor: IcoColors.yellow1,
                      indexText: "???????????????",
                      contentText:
                          "?????? ?????? ???, ?????? ???????????? ???????????? ?????? ???????????? ?????? ????????????????????????. ????????? ?????? ???, ?????????????????? ??????????????? ??????????????? ???????????? ???????????????. ",
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: IcoColors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 27,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "???????????????",
                              style: IcoTextStyle.boldTextStyle22P,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '???\n????????? ?????????????????????',
                                    style: IcoTextStyle.boldTextStyle22B),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    GraphBoxWithDottedLine(
                      box1Color: IcoColors.purple3,
                      box1Text: "?????????",
                      box2Color: IcoColors.primary,
                      box2Text: "??????",
                      lineText: "???????????????",
                      box1TextStyle: IcoTextStyle.boldTextStyle15B,
                      box2TextStyle: IcoTextStyle.boldTextStyle15W,
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    ColorIndexBox(
                      contentText:
                          "????????? ???????????? ?????? ?????? ???????????? ???????????????.\n???????????? ??????????????? ????????? ???????????????.",
                      indexColor: IcoColors.purple3,
                      indexText: '?????????',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ColorIndexBox(
                      indexColor: IcoColors.primary,
                      indexText: "??????",
                      contentText:
                          "???????????? ????????? ????????? ????????????????????????.\n????????? ????????? 4??? ????????? ????????? ??????????????? ??????\n??????????????? ??????????????? ??????????????????.",
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}

class ColorIndexBox extends StatelessWidget {
  ColorIndexBox(
      {Key? key,
      required this.indexColor,
      required this.indexText,
      required this.contentText})
      : super(key: key);

  Color indexColor;
  String indexText;
  String contentText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: IcoColors.grey1, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircleAvatar(
                  backgroundColor: indexColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                indexText,
                style: IcoTextStyle.boldTextStyle15B,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            contentText,
            style: IcoTextStyle.regularTextStyle13B,
          )
        ],
      ),
    );
  }
}

class GraphBoxWithDottedLine extends StatelessWidget {
  GraphBoxWithDottedLine({
    Key? key,
    required this.lineText,
    required this.box1Color,
    required this.box2Color,
    required this.box1Text,
    required this.box2Text,
    required this.box1TextStyle,
    required this.box2TextStyle,
  }) : super(key: key);
  String lineText;
  Color box1Color;
  Color box2Color;
  String box1Text;
  String box2Text;
  TextStyle box1TextStyle;
  TextStyle box2TextStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              height: 400,
              width: IcoSize.width,
            ),
          ),
          Positioned(
            top: 0,
            child: Text(lineText, style: IcoTextStyle.boldTextStyle15Grey4),
          ),
          Positioned(
            top: 27,
            child: Container(
              width: IcoSize.width - 42,
              height: 45,
              decoration: DottedDecoration(
                strokeWidth: 2,
                dash: <int>[3, 3],
                color: IcoColors.grey3,
                shape: Shape.box,
                borderRadius: BorderRadius.circular(
                    10), //remove this to get plane rectange
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: SizedBox(
              width: IcoSize.width - 40,
              height: 45,
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        child: Text(box1Text, style: box1TextStyle),
                        decoration: BoxDecoration(
                            color: box1Color,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        child: Text(box2Text, style: box2TextStyle),
                        decoration: BoxDecoration(
                            color: box2Color,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
