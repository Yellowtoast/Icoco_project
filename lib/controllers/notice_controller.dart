import 'dart:convert';

import 'package:app/configs/insurance_standards.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/helpers/calc_date.dart';
import 'package:app/helpers/formatter.dart';
import 'package:app/models/notice.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class NoticeController extends GetxController {
  AuthController _authController = Get.find();
  RxInt noticeOffset = 0.obs;
  RxInt noticelimitNumber = 10.obs;
  RxList<NoticeModel> noticeModelList = RxList<NoticeModel>();

  @override
  Future<void> onReady() async {
    noticeModelList =
        (await getJsonEvent(noticeOffset.value, noticelimitNumber.value))!;
    noticeModelList.refresh();
    super.onReady();
  }

  // @override
  // void onReady() {

  //   super.onReady();
  // }

  Future<RxList<NoticeModel>?> getJsonEvent(int offset, int limitNumber) async {
    RxList<NoticeModel> noticeModelList = RxList<NoticeModel>();
    var currentUser = await _authController.getUser;
    String userToken = await currentUser.getIdToken();

    var queryParameters = {
      "offset": offset.toString(),
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
      var noticeList = responseObject['data'];
      for (var eventData in noticeList) {
        var res = eventData.cast<dynamic, dynamic>();
        NoticeModel noticeModel;
        noticeModel = NoticeModel.fromJson(res);
        noticeModelList.add(noticeModel);
      }

      return noticeModelList;
    } catch (e) {
      print('리뷰 불러오기 실패, null 배열 리턴');
      return null;
    }
  }
}
