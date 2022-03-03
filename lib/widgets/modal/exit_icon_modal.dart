import 'package:app/configs/colors.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future<dynamic> exitIconModal(
    String? title,
    String? subtitle,
    String? buttonText,
    void Function()? onPressed,
    String? iconSrc,
    double? iconHeight) {
  void Function()? _onPressed = onPressed;
  String? _buttonText = buttonText;
  String? _title = title;
  String? _subtitle = subtitle;
  String? _iconSrc = iconSrc;
  double? _iconHeight = iconHeight;

  return Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                width: 335,
                // height: 328,
                decoration: BoxDecoration(
                  color: IcoColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      _iconSrc ?? "icons/modal_call.svg",
                      height: _iconHeight ?? 66,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _title ?? "전화 연결을 통해\n일정을 수정해주세요",
                      textAlign: TextAlign.center,
                      style: IcoTextStyle.boldTextStyle22B,
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      _subtitle ?? "아이코코 고객센터를 통해\n서비스 일정을 수정해주세요",
                      textAlign: TextAlign.center,
                      style: IcoTextStyle.mediumTextStyle14B,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: IcoButton(
                              width: 292,
                              height: 50,
                              onPressed:
                                  _onPressed ?? () => Get.back(result: true),
                              active: true.obs,
                              textStyle: IcoTextStyle.buttonTextStyleW,
                              text: _buttonText ?? '확인'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 15,
            top: 15,
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "icons/modal_close.svg",
                  width: 27,
                  height: 27,
                )),
          ),
        ],
      ),
    ),
  );
}
