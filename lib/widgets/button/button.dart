import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IcoButton extends StatelessWidget {
  IcoButton({
    Key? key,
    required this.onPressed,
    required this.active,
    required this.textStyle,
    required this.text,
    this.leadingIcon = false,
    this.icon = false,
    this.iconColor = Colors.black,
    this.border = false,
    this.buttonColor = IcoColors.primary,
    this.height = 56,
    this.width = double.infinity,
    this.borderColor = IcoColors.primary,
    this.textAlign = MainAxisAlignment.center,

    // required this.onTap
  }) : super(key: key);

  final bool icon;
  final bool leadingIcon;
  final Color iconColor;
  final bool border;
  Color buttonColor;
  Color borderColor;
  final TextStyle textStyle;
  final String text;
  final void Function() onPressed;
  Rx<bool> active;

  double height = 50;
  double width;
  MainAxisAlignment textAlign;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(() {
          return Container(
            padding: (textAlign == MainAxisAlignment.start)
                ? const EdgeInsets.only(left: 5)
                : null,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: (active.value) ? buttonColor : IcoColors.grey2,
              borderRadius: BorderRadius.circular(10),
              border: (border)
                  ? Border.all(
                      color: borderColor,
                      width: 1,
                    )
                  : Border.all(color: Colors.transparent),
            ),
            child: TextButton(
              onPressed: (active.value) ? onPressed : () {},
              child: Row(
                mainAxisAlignment: textAlign,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          );
        }),
        (icon)
            ? Positioned(
                right: 13,
                child: SvgPicture.asset(
                  'icons/button_arrow.svg',
                  color: iconColor,
                ),
              )
            : SizedBox(),
        (leadingIcon)
            ? Visibility(
                visible: leadingIcon,
                child: Positioned(
                  left: 13,
                  child: SvgPicture.asset(
                    'icons/kakao.svg',
                    color: iconColor,
                  ),
                ),
              )
            : Visibility(
                visible: leadingIcon,
                child: Positioned(
                  left: 13,
                  child: SvgPicture.asset(
                    'icons/kakao.svg',
                    color: iconColor,
                  ),
                ),
              )
      ],
    );
  }
}
