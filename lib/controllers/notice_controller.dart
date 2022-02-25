import 'dart:convert';
import 'package:app/controllers/auth_controller.dart';
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
  RxList<NoticeModel> noticeModelList = RxList<NoticeModel>();
  RxBool isPageLoading = false.obs;
  var scrollController = ScrollController();
  var isLoading = false.obs;
  var hasMore = false.obs;
  var isShow = true.obs;
  RxBool pageInit = false.obs;

  @override
  void onReady() async {
    startLoadingIndicator();
    await getJsonNoticeData(offset, limitNumber.value);
    finishLoadingIndicator();
    getDataByScrollEvent();

    super.onReady();
  }

  getDataByScrollEvent() {
    scrollController.addListener(() async {
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
  }

  getJsonNoticeData(RxInt offset, int limitNumber) async {
    isLoading.value = true;
    List<dynamic> newList = [];
    var currentUser = await _authController.getUser;
    String userToken = await currentUser.getIdToken();

    var queryParameters = {
      "offset": offset.value.toString(),
      "limitNumber": limitNumber.toString(),
    };

    try {
      var uri = Uri.https(
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
        newList.add(noticeModel);
      }
      offset.value += newList.length;
      isLoading.value = false;
      hasMore.value = newList.length >= limitNumber;
      noticeModelList.value = [...noticeModelList, ...newList];
    } catch (e) {
      return [].obs;
    }
  }
}
