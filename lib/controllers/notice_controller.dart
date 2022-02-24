import 'dart:convert';

import 'package:app/configs/insurance_standards.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/scroll_controller.dart';
import 'package:app/helpers/calc_date.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/notice.dart';
import 'package:app/pages/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class NoticeController extends GetxController {
  AuthController _authController = Get.find();
  RxInt offset = 0.obs;
  RxInt limitNumber = 10.obs;
  RxList<dynamic> noticeModelList = RxList<dynamic>();
  RxBool isPageLoading = false.obs;
  // RxBool isListLoading = false.obs;
  var scrollController = ScrollController();
  var isLoading = false.obs;
  var hasMore = false.obs;
  var isShow = true.obs;

  @override
  void onInit() async {
    print('oninit');
    // scrollController.addListener(() async {
    //   print('scrollcontroller');
    //   if (scrollController.position.pixels ==
    //           scrollController.position.maxScrollExtent &&
    //       hasMore.value) {
    //     noticeModelList.value =
    //         await getJsonNoticeData(offset, limitNumber.value);
    //   }

    //   final direction = scrollController.position.userScrollDirection;
    //   if (direction == ScrollDirection.forward) {
    //     isShow.value = true;
    //   } else {
    //     isShow.value = false;
    //   }
    // });

    super.onInit();
  }

  @override
  void onReady() async {
    once(isPageLoading, (_) async {
      changeInitialLoading(isPageLoading.value);
      noticeModelList.value =
          await getJsonNoticeData(offset, limitNumber.value);
      noticeModelList.refresh();
      isPageLoading.value = false;
    });
    isPageLoading.value = true;

    ever(isPageLoading, changeInitialLoading);

    scrollController.addListener(() async {
      print('scrollcontroller');
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value) {
        getJsonNoticeData(offset, limitNumber.value);
      }

      final direction = scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        isShow.value = true;
      } else {
        isShow.value = false;
      }
    });

    super.onReady();
  }

  changeInitialLoading(_isLoading) {
    if (_isLoading == true) {
      startLoadingIndicator();
    } else {
      finishLoadingIndicator();
    }
  }

  getJsonNoticeData(RxInt offset, int limitNumber) async {
    isLoading.value = true;
    RxList<dynamic> noticeList = [].obs;
    var currentUser = await _authController.getUser;
    String userToken = await currentUser.getIdToken();

    var queryParameters = {
      "offset": offset.value.toString(),
      "limitNumber": limitNumber.toString(),
    };

    try {
      var uri = Uri.http(
          'icoco2022-adminweb.vercel.app', '/api/getNotice', queryParameters);

      var response = await http.get(
        uri,
        headers: {'x-access-token': userToken},
      );
      var responseObject = jsonDecode(response.body);
      var responseList = responseObject['data'];
      for (var eventData in responseList) {
        var res = eventData.cast<dynamic, dynamic>();
        NoticeModel noticeModel;
        noticeModel = NoticeModel.fromJson(res);
        noticeList.add(noticeModel);
      }
      offset.value += noticeList.length;
      isLoading.value = false;
      hasMore.value = noticeList.length >= limitNumber;
      noticeModelList.add(noticeList);
    } catch (e) {
      print('리뷰 불러오기 실패, null 배열 리턴');
      return [].obs;
    }
  }

  // _getData() async {
  //   isLoading.value = true;

  //   int offset = data.length;

  //   var appendData = List<int>.generate(10, (i) => i + 1 + offset);

  //   data.addAll(appendData);

  //   isLoading.value = false;

  //   hasMore.value = data.length < 50;
  // }
}



// class NoticeController extends GetxController {
//   AuthController _authController = Get.find();
//   RxInt noticeOffset = 0.obs;
//   RxInt noticelimitNumber = 10.obs;
//   RxList<dynamic> noticeModelList = RxList<dynamic>();
//   RxBool isPageLoading = false.obs;
//   RxBool isListLoading = false.obs;
//   RxBool hasMore = false.obs;
//   MyScrollController myScrollController = Get.put(MyScrollController());

//   @override
//   void onInit() async {
//     super.onInit();
//   }

//   @override
//   void onReady() async {
//     once(isPageLoading, (_) async {
//       changeInitialLoading(isPageLoading.value);
//       noticeModelList.value =
//           await getJsonEvent(noticeOffset.value, noticelimitNumber.value);
//       noticeModelList.refresh();
//       isPageLoading.value = false;
//     });
//     isPageLoading.value = true;

//     ever(isPageLoading, changeInitialLoading);

//     super.onReady();
//   }

//   changeInitialLoading(_isLoading) {
//     if (_isLoading == true) {
//       startLoadingIndicator();
//     } else {
//       finishLoadingIndicator();
//     }
//   }

//   getJsonEvent(int offset, int limitNumber) async {
//     List<dynamic> noticeList = [];
//     var currentUser = await _authController.getUser;
//     String userToken = await currentUser.getIdToken();

//     var queryParameters = {
//       "offset": offset.toString(),
//       "limitNumber": limitNumber.toString(),
//     };

//     try {
//       var uri = Uri.http(
//           'icoco2022-adminweb.vercel.app', '/api/getNotice', queryParameters);

//       var response = await http.get(
//         uri,
//         headers: {'x-access-token': userToken},
//       );
//       var responseObject = jsonDecode(response.body);
//       var responseList = responseObject['data'];
//       for (var eventData in responseList) {
//         var res = eventData.cast<dynamic, dynamic>();
//         NoticeModel noticeModel;
//         noticeModel = NoticeModel.fromJson(res);
//         noticeList.add(noticeModel);
//       }
//       isListLoading.value = false;
//       return noticeList;
//     } catch (e) {
//       print('리뷰 불러오기 실패, null 배열 리턴');
//       return [].obs;
//     }
//   }
// }
