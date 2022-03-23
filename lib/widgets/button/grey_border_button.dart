import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';

class BorderButton extends StatelessWidget {
  BorderButton(
      {Key? key,
      required this.width,
      required this.onTap,
      this.height = 50,
      this.buttonText = '내 예약정보 보기',
      required this.borderColor,
      required this.textStyle,
      this.buttonColor = Colors.white})
      : super(key: key);
  double width;
  double height;
  String buttonText;
  void Function() onTap;
  Color borderColor;
  Color buttonColor;
  TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Text(
          buttonText,
          style: textStyle,
        ),
        decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
