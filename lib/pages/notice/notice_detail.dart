import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NoticeDetailPage extends StatelessWidget {
  NoticeDetailPage({Key? key}) : super(key: key);

  var noticeNum = Get.arguments['noticeNum'];
  var controllerTag = Get.arguments['controllerTag'];
  @override
  Widget build(BuildContext context) {
    NoticeController _noticeController = Get.find(tag: controllerTag);
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
                      _noticeController.noticeModelList[noticeNum].title,
                      style: IcoTextStyle.boldTextStyle20B,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(dateFormatWithDot.format(
                        _noticeController.noticeModelList[noticeNum].date)),
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
                    Text(_noticeController.noticeModelList[noticeNum].subtitle),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                );
              }),
            ),
            Obx(
              () => Image.network(
                  _noticeController.noticeModelList[noticeNum].thumbnail!,
                  errorBuilder: (context, error, stackTrace) => SizedBox()),
            )
          ],
        ),
      ),
    );
  }
}
