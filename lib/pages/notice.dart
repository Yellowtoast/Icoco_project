import 'package:app/configs/colors.dart';
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

class NoticePage extends StatelessWidget {
  NoticePage({Key? key}) : super(key: key);
  NoticeController _noticeController = Get.find();

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
      body: Obx(() {
        return SizedBox(
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
                          Container(
                            height: 88,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      dateFormatWithDot.format(_noticeController
                                          .noticeModelList[index].date),
                                      style:
                                          IcoTextStyle.mediumTextStyle14Grey4,
                                    ),
                                  ],
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
    );
  }
}







// import 'package:app/configs/colors.dart';
// import 'package:app/controllers/notice_controller.dart';
// import 'package:app/controllers/scroll_controller.dart';
// import 'package:app/helpers/formatter.dart';
// import 'package:app/configs/text_styles.dart';
// import 'package:app/pages/loading.dart';
// import 'package:app/widgets/appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class NoticePage extends StatelessWidget {
//   NoticePage({Key? key}) : super(key: key);
//   NoticeController _noticeController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: IcoColors.white,
//       appBar: IcoAppbar(
//         title: "공지사항",
//         usePop: true,
//         tapFunction: () {
//           Get.back();
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Obx(() {
//           return SizedBox(
//             height: _noticeController.noticeModelList.length * 88,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: InfinityScrollWidget(
//                     itemBuilder: (BuildContext context, int index) {
//                       return Column(
//                         children: [
//                           Container(
//                             height: 88,
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       _noticeController
//                                           .noticeModelList[index].title,
//                                       style: IcoTextStyle.boldTextStyle17B,
//                                     ),
//                                     SizedBox(
//                                       height: 4,
//                                     ),
//                                     Text(
//                                       dateFormatWithDot.format(_noticeController
//                                           .noticeModelList[index].date),
//                                       style:
//                                           IcoTextStyle.mediumTextStyle14Grey4,
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   width: 50,
//                                   height: double.infinity,
//                                   alignment: Alignment.centerRight,
//                                   child: SizedBox(
//                                     child: SvgPicture.asset(
//                                       'icons/button_arrow.svg',
//                                       color: IcoColors.grey3,
//                                       width: 16,
//                                       fit: BoxFit.none,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             height: 1,
//                             color: IcoColors.grey2,
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 Obx(() => _noticeController.isListLoading.value
//                     ? SizedBox(height: 100, child: CupertinoActivityIndicator())
//                     : SizedBox())
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class InfinityScrollWidget extends StatelessWidget {
//   InfinityScrollWidget({
//     Key? key,
//     required ScrollController scrollController,
//     required int itemCount,
//     required Widget Function(BuildContext, int) itemBuilder,
//   })  : _scrollController = scrollController,
//         _itemCount = itemCount,
//         _itemBuilder = itemBuilder,
//         super(key: key);

//   final ScrollController? _scrollController;
//   final int _itemCount;
//   final Widget Function(BuildContext, int) _itemBuilder;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         controller: _scrollController,
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: _itemCount,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: _itemBuilder);
//   }
// }
