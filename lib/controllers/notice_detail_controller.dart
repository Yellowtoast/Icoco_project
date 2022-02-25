// import 'package:get/get.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:app/models/event.dart';
// import 'package:app/pages/loading.dart';

// import '../models/notice.dart';

// class NoticeDetailController extends GetxController {
//   var pageArguments = Get.arguments;
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   Rxn<NoticeModel> noticeModel = Rxn<NoticeModel>();

//   @override
//   void onReady() async {
//     super.onReady();
//     initRequest();
//   }

//   @override
//   Future<void> onClose() async {
//     super.onClose();
//   }

//   Future<void> initRequest() async {
//     startLoadingIndicator();
//     var noticeId = pageArguments["noticeId"];
//     var querySanpshot = await db.collection('Notice').doc(noticeId).get();
//     NoticeModel model =
//         NoticeModel.fromJson({"id": noticeId, ...?querySanpshot.data()});
//     noticeModel.value = model;
//     finishLoadingIndicator();
//   }
// }
