import 'package:app/configs/colors.dart';
import 'package:app/configs/size.dart';
import 'package:app/controllers/notice_controller.dart';
import 'package:app/controllers/tip_controller.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/configs/text_styles.dart';
import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/routes.dart';
import 'event/event.dart';

class TipPage extends StatelessWidget {
  TipPage({Key? key}) : super(key: key);
  TipController _tipController = Get.put(TipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IcoColors.white,
      appBar: IcoAppbar(
        title: "육아 팁",
        usePop: true,
        tapFunction: () {
          Get.back();
        },
      ),
      body: Obx(() {
        return Column(
          children: [
            SizedBox(
              height: 13,
            ),
            Container(
              height: 65,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _tipController.tipMenuList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: (index == 0) ? 20 : 8,
                            ),
                            GestureDetector(
                              onTap: () => _tipController.selectedMenu.value =
                                  _tipController.tipMenuList[index],
                              child: Container(
                                width: 120,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: (_tipController.selectedMenu.value ==
                                            _tipController.tipMenuList[index])
                                        ? IcoColors.purple1
                                        : IcoColors.grey1,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "#${_tipController.tipMenuList[index]}",
                                  style: (_tipController.selectedMenu.value ==
                                          _tipController.tipMenuList[index])
                                      ? IcoTextStyle.boldTextStyle15P
                                      : IcoTextStyle.boldTextStyle15B,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (index == 8) ? 20 : 0,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            (_tipController.tipList.isEmpty)
                ? EmptyListPage(
                    title: '등록된 육아팁이 없습니다', subtitle: '이 카테고리에 등록된 육아팁이 없습니다')
                : SizedBox(
                    height: IcoSize.height - IcoSize.appbarHeight - 65 - 24,
                    child: Column(
                      children: [
                        Obx(() {
                          return Expanded(
                            child: ListView.builder(
                                // controller: _tipController.scrollController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _tipController.tipList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print(index);
                                          Get.toNamed(Routes.TIP_DETAIL,
                                              arguments: {'tipNum': index});
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 375,
                                              width: IcoSize.width,
                                              color: IcoColors.grey1,
                                              child: Image.network(
                                                _tipController.tipList[index]
                                                    .thumbnails[0],
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  "images/empty_profile.png",
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 132,
                                              width: IcoSize.width - 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _tipController
                                                            .tipList[index]
                                                            .title,
                                                        style: IcoTextStyle
                                                            .boldTextStyle17B,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        dateFormatWithDot
                                                            .format(
                                                                _tipController
                                                                    .tipList[
                                                                        index]
                                                                    .date),
                                                        style: IcoTextStyle
                                                            .mediumTextStyle14B,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            IcoSize.width - 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  child: Image
                                                                      .network(
                                                                    _tipController
                                                                        .tipList[
                                                                            index]
                                                                        .profileImage,
                                                                    width: 28,
                                                                    height: 28,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  _tipController
                                                                      .tipList[
                                                                          index]
                                                                      .authorId,
                                                                  style: IcoTextStyle
                                                                      .boldTextStyle14B,
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              dateFormatWithDot.format(
                                                                  _tipController
                                                                      .tipList[
                                                                          index]
                                                                      .date),
                                                              style: IcoTextStyle
                                                                  .mediumTextStyle12B,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
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
                          );
                        }),
                        Obx(() => _tipController.isLoading.value
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
                  )
          ],
        );
      }),
    );
  }
}
