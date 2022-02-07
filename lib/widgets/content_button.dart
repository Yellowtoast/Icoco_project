import 'package:app/configs/colors.dart';
import 'package:flutter/material.dart';

class ContentsButton extends StatelessWidget {
  const ContentsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 69,
        height: 29,
        decoration: BoxDecoration(
            color: IcoColors.grey1, borderRadius: BorderRadius.circular(50)),
        child: TextButton(
            onPressed: () {},
            child: Text(
              '내용보기',
              // textAlign: TextAlign.center,
              style:
                  TextStyle(height: 1.1, color: IcoColors.grey4, fontSize: 11),
            )));
  }
}
