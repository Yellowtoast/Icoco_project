import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:app/controllers/scroll_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/pages/loading.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NoticeDetailPage extends StatelessWidget {
  NoticeDetailPage({Key? key}) : super(key: key);

  NoticeController _noticeController = Get.find();
  var eventNum = Get.arguments['eventNum'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: "공지사항",
        usePop: true,
        tapFunction: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 38,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _noticeController.noticeModelList[eventNum].title,
                      style: IcoTextStyle.boldTextStyle20B,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(dateFormatWithDot.format(
                        _noticeController.noticeModelList[eventNum].date)),
                    SizedBox(
                      height: 25,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Text(_noticeController.noticeModelList[eventNum].subtitle),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                );
              }),
            ),
            Obx(
              () => Image.network(
                  _noticeController.noticeModelList[eventNum].thumbnail!,
                  errorBuilder: (context, error, stackTrace) => SizedBox()),
            )
          ],
        ),
      ),
    );
  }
}
