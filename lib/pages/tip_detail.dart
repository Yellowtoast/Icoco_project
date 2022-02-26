import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:app/controllers/tip_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/pages/loading.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TipDetailPage extends StatelessWidget {
  TipDetailPage({Key? key}) : super(key: key);

  var tipNum = Get.arguments['tipNum'];
  @override
  Widget build(BuildContext context) {
    TipController _tipController = Get.find();
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: _tipController.tipList[tipNum].title,
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
                      _tipController.tipList[tipNum].title,
                      style: IcoTextStyle.boldTextStyle20B,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(dateFormatWithDot
                        .format(_tipController.tipList[tipNum].date)),
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
                    Text(
                      _tipController.tipList[tipNum].contents,
                      style: IcoTextStyle.mediumTextStyle15B,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: IcoSize.width - 40,
                      height: 20,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: _tipController.tipList[tipNum].tags.length,
                          itemBuilder: ((context, index) => Text(
                                "#${_tipController.tipList[tipNum].tags[index]}",
                                style: IcoTextStyle.boldTextStyle15P,
                              ))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                );
              }),
            ),
            Obx(
              () => SizedBox(
                height: _tipController.tipList[tipNum].thumbnails.length * 375,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _tipController.tipList[tipNum].thumbnails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 375,
                        width: IcoSize.width,
                        color: IcoColors.grey1,
                        child: Image.network(
                          _tipController.tipList[tipNum].thumbnails[index],
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "images/empty_profile.png",
                            width: 28,
                            height: 28,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
