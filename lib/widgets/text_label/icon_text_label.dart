import 'package:app/configs/text_styles.dart';
import 'package:flutter/material.dart';

class IconTextLabel extends StatelessWidget {
  IconTextLabel({Key? key, required this.text, this.icon}) : super(key: key);

  String text;
  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon ?? SizedBox(),
        SizedBox(
          width: (icon != null) ? 7 : 0,
        ),
        Text(text, style: IcoTextStyle.boldTextStyle15B),
      ],
    );
  }
}
