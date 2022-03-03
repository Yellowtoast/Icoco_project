import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';

class GreyBorderButton extends StatelessWidget {
  GreyBorderButton({
    Key? key,
    required this.width,
    required this.onTap,
    this.height = 50,
    this.buttonText = '내 예약정보 보기',
  }) : super(key: key);
  double width;
  double height;
  String buttonText;
  void Function() onTap;
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
          style: IcoTextStyle.mediumTextStyle15B,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: IcoColors.grey2),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
