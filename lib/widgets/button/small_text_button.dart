import 'package:app/configs/colors.dart';
import 'package:app/pages/guide_page/empty_content_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallTextButton extends StatelessWidget {
  const SmallTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 69,
        height: 29,
        decoration: BoxDecoration(
            color: IcoColors.grey1, borderRadius: BorderRadius.circular(50)),
        child: TextButton(
            onPressed: () {
              Get.to(EmptyInfoPage(
                appbarText: '내용보기',
                title: '',
                subtitle: '',
              ));
            },
            child: Text(
              '내용보기',
              textAlign: TextAlign.center,
              style:
                  TextStyle(height: 1.1, color: IcoColors.grey4, fontSize: 11),
            )));
  }
}
