import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:app/pages/notice/notice_detail.dart';
import 'package:app/widgets/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../configs/routes.dart';
import '../event/event.dart';

class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  String controllerTag = 'fromBinding';

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
      body: Obx(() {
        return (_noticeController.noticeModelList.isEmpty &&
                !_noticeController.isPageLoading.value)
            ? Center(
                child: EmptyListPage(
                    title: '공지사항이 없습니다', subtitle: '등록된 공지 글이 없습니다'))
            : SizedBox(
                height: _noticeController.noticeModelList.length * 88,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _noticeController.scrollController,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _noticeController.noticeModelList.length,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print(index);
                                    Get.toNamed(Routes.NOTICE_DETAIL,
                                        arguments: {
                                          'noticeNum': index,
                                          'controllerTag': 'fromBinding'
                                        });
                                  },
                                  child: Container(
                                    height: 88,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _noticeController
                                                    .noticeModelList[index]
                                                    .title,
                                                style: IcoTextStyle
                                                    .boldTextStyle17B,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                dateFormatWithDot.format(
                                                    _noticeController
                                                        .noticeModelList[index]
                                                        .date),
                                                style: IcoTextStyle
                                                    .mediumTextStyle14Grey4,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          height: double.infinity,
                                          alignment: Alignment.centerRight,
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
                                ),
                                Divider(
                                  height: 1,
                                  color: IcoColors.grey2,
                                )
                              ],
                            );
                          }),
                    ),
                    Obx(() => _noticeController.isListLoading.value
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: IcoColors.purple3,
                              strokeWidth: 4,
                            ),
                          )
                        : SizedBox())
                  ],
                ),
              );
      }),
    );
  }
}
