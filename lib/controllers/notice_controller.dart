import 'dart:convert';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/models/notice.dart';
import 'package:app/widgets/loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class NoticeController extends GetxController {
  AuthController _authController = Get.find();
  RxInt offset = 0.obs;
  RxInt limitNumber = 10.obs;
  RxList<NoticeModel> noticeModelList = RxList<NoticeModel>();

  var scrollController = ScrollController();
  var isListLoading = false.obs;
  var isPageLoading = true.obs;
  var hasMore = false.obs;
  var isShow = true.obs;

  @override
  void onReady() async {
    super.onReady();
    loading(
      () => getJsonNoticeData(offset, limitNumber.value),
    );
    await getDataByScrollEvent();
  }

  getDataByScrollEvent() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value) {
        isListLoading.value = true;
        await getJsonNoticeData(offset, limitNumber.value);
        isListLoading.value = false;
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
        NoticeModel noticeModel;
        noticeModel = NoticeModel.fromJson(eventData);
        newList.add(noticeModel);
      }
      offset.value += newList.length;

      hasMore.value = newList.length >= limitNumber;
      noticeModelList.value = [...noticeModelList, ...newList];
      isListLoading.value = false;
    } catch (e) {
      return [].obs;
    }
  }
}
