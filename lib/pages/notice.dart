import 'package:app/configs/colors.dart';
import 'package:app/configs/formats.dart';
import 'package:app/configs/size.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/company_controller.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:app/controllers/refund_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/routes.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/pages/manager/manager_detail.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/button/button.dart';
import 'package:app/widgets/textfield/textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../widgets/modal/bottomup_modal2.dart';
import '../widgets/modal/option_modal.dart';

class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  final NoticeController _noticeController = Get.put(NoticeController());
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
        child: Obx(() {
          return SizedBox(
            height: _noticeController.noticeModelList.length * 88,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _noticeController.noticeModelList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              height: 88,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _noticeController
                                            .noticeModelList[index].title,
                                        style: IcoTextStyle.boldTextStyle17B,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        dateFormatWithDot.format(
                                            _noticeController
                                                .noticeModelList[index].date),
                                        style:
                                            IcoTextStyle.mediumTextStyle14Grey4,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: double.infinity,
                                    child: SizedBox(
                                      child: SvgPicture.asset(
                                        'icons/button_arrow.svg',
                                        color: IcoColors.grey3,
                                        width: 16,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: IcoColors.grey2,
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
