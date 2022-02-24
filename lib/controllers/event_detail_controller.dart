import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/models/event.dart';
import 'package:app/pages/loading.dart';

class EventDetailController extends GetxController {
  var pageArguments = Get.arguments;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Rx<String> id = ''.obs;
  Rx<String> appBanner = ''.obs;
  Rx<String> author = ''.obs;
  Rx<String> contents = ''.obs;
  Rx<int> date = 0.obs;
  Rx<String> detailThumbnail = ''.obs;
  Rx<String> startDate = ''.obs;
  Rx<String> endDate = ''.obs;
  Rx<bool> moveTo = true.obs;
  Rx<String> status = ''.obs;
  Rx<String> thumbnail = ''.obs;
  Rx<String> title = ''.obs;

  @override
  void onReady() async {
    super.onReady();
    initRequest();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  Future<void> initRequest() async {
    startLoadingIndicator();
    var eventId = pageArguments["eventId"];
    var querySanpshot = await db.collection('Event').doc(eventId).get();

    var event = EventModel.fromJson({"id": eventId, ...?querySanpshot.data()});

    id.value = eventId;
    appBanner.value = event.appBanner;
    author.value = event.author;
    contents.value = event.contents;
    date.value = event.date;
    detailThumbnail.value = event.detailThumbnail;
    startDate.value = event.startDate;
    endDate.value = event.endDate;
    moveTo.value = event.moveTo;
    status.value = event.status;
    thumbnail.value = event.thumbnail;
    title.value = event.title;

    finishLoadingIndicator();
  }
}
