import 'package:app/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Rx<bool> initialLoading = false.obs;
  RxList<EventModel> runningEvents = RxList<EventModel>();
  RxList<EventModel> completedEvents = RxList<EventModel>();
  RxList<EventModel> announcedEvents = RxList<EventModel>();
  RxnInt totalEventNumber = RxnInt();
  @override
  void onReady() async {
    super.onReady();
    initRequest();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  // Future<void> initRequest() async {
  //   var querySanpshots = await db.collection('Event').get();
  //   List<EventModel> totalEventModel = [];
  //   EventModel eventModel;

  //   querySanpshots.docs.forEach((snapshot) {
  //     eventModel = EventModel.fromJson({"id": snapshot.id, ...snapshot.data()});
  //     totalEventModel.add(eventModel);
  //   });

  //   totalEventModel.forEach((event) {
  //     if (event.status == 'running') {
  //       runningEvents.add(event);
  //     }
  //     if (event.status == 'announced') {
  //       announcedEvents.add(event);
  //     }
  //     if (event.status == 'completed') {
  //       completedEvents.add(event);
  //     }
  //   });
  //   initialLoading.value = false;
  // }

  // Future<void> initRequest() async {
  //   var querySanpshots = await db.collection('Event').get();
  //   RxList<EventModel> list = RxList<EventModel>();
  //   dynamic event;

  //   querySanpshots.docs.map((snapshot) {
  //     event = EventModel.fromJson({"id": snapshot.id, ...snapshot.data()});
  //     list.add(event!);
  //   });
  //   list.map((event) {
  //     if (event.status == 'running') {
  //       runningEvents.add(event);
  //     }
  //     if (event.status == 'announced') {
  //       announcedEvents.add(event);
  //     }
  //     if (event.status == 'completed') {
  //       completedEvents.add(event);
  //     }
  //   });
  //   initialLoading.value = false;
  // }

  // Future<void> initRequest() async {
  //   var querySanpshots = await db.collection('Event').get();
  //   // List<EventModel> totalEventList = [];
  //   querySanpshots.docs.map((snapshot) {
  //     totalEventList
  //         .add(
  //EventModel.fromJson({"id": snapshot.id, ...snapshot.data()}));
  //   });

  //   totalEventList.map((event) {
  //     if (event.status == 'running') {
  //       runningEvents.add(event);
  //     }
  //     if (event.status == 'announced') {
  //       announcedEvents.add(event);
  //     }
  //     if (event.status == 'completed') {
  //       completedEvents.add(event);
  //     }
  //   });

  //   initialLoading.value = false;
  // }

  Future<void> initRequest() async {
    var querySanpshots = await db.collection('Event').get();
    totalEventNumber.value = querySanpshots.docs.length;
    Iterable<EventModel> list = querySanpshots.docs.map((snapshot) =>
        EventModel.fromJson({"id": snapshot.id, ...snapshot.data()}));

    list.forEach((event) {
      if (event.status == 'running') {
        runningEvents.add(event);
      }
      if (event.status == 'announced') {
        announcedEvents.add(event);
      }
      if (event.status == 'completed') {
        completedEvents.add(event);
      }
    });

    initialLoading.value = false;
  }
}
