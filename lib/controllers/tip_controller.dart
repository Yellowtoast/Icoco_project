import 'package:app/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/tip.dart';

class Tip {
  static String helperInfo = '도우미정보';
  static String nurturingInfo = '육아정보';
  static String govermentInfo = '정부혜택';
  static String postpartumInfo = '산후관리';
  static String birthInfo = '출산';
  static String newbornInfo = '신생아';
  static String infantInfo = '영유아';
  static String localInfo = '지역정보';
}

class TipController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  var scrollController = ScrollController();
  var isLoading = false.obs;
  var hasMore = false.obs;
  var isShow = true.obs;
  Rx<bool> initialLoading = false.obs;
  RxList<TipModel> tipList = RxList<TipModel>();
  Rx<String> selectedMenu = Tip.helperInfo.obs;
  List<String> tipMenuList = [
    Tip.helperInfo,
    Tip.nurturingInfo,
    Tip.govermentInfo,
    Tip.postpartumInfo,
    Tip.birthInfo,
    Tip.newbornInfo,
    Tip.infantInfo,
    Tip.localInfo
  ];

  @override
  void onInit() async {
    super.onInit();
    dataRequest(selectedMenu.value);
  }

  @override
  void onReady() async {
    super.onReady();
    ever(selectedMenu, dataRequest);
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  Future<void> dataRequest(_selectedMenu) async {
    var querySanpshots = await db
        .collection('Tip')
        .where('keyword', isEqualTo: _selectedMenu)
        .get();

    tipList.clear();

    querySanpshots.docs.forEach((snapshot) {
      tipList.add(TipModel.fromJson(snapshot.data()));
    });

    tipList.refresh();
    initialLoading.value = false;
  }
}
