import 'package:app/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Rx<bool> initialLoading = false.obs;
  RxList<dynamic> events = [].obs;

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
    var querySanpshots = await db.collection('Event').get();
    var list = querySanpshots.docs.map((snapshot) =>
        EventModel.fromJson({"id": snapshot.id, ...snapshot.data()}));
    events.assignAll(list);
    initialLoading.value = false;
  }
}
