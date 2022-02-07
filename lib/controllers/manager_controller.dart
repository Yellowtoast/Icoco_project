import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/models/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManagerController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Rxn<ManagerModel> managerModel = Rxn<ManagerModel>();
  RxList<Rxn<ManagerModel>> managerModelList = RxList<Rxn<ManagerModel>>();
  HomeController homeController = Get.find();
  ReviewController reviewController = Get.find();

  @override
  onInit() async {
    await getFirebaseManagerModel(
        homeController.reservationModel.value!.reservationNumber);

    super.onInit();
  }

  // Future<RxList<Rxn<ManagerModel>>>
  getFirebaseManagerModel(String reservationNumber) async {
    List<dynamic> queryDocumentList = [];
    RxList<Rxn<ManagerModel>> modelList = RxList<Rxn<ManagerModel>>();
    try {
      if (reservationNumber != "") {
        var doc = await db
            .collection('Manager')
            .where('reservationNumber', isEqualTo: reservationNumber)
            .get();
        doc.docs.forEach((element) {
          queryDocumentList.add(element);
        });
        queryDocumentList.forEach((element) {
          Rxn<ManagerModel> model = Rxn<ManagerModel>();
          model.value = ManagerModel.fromJson(element.data());
          managerModelList.add(model);
        });
        managerModelList.refresh();
      }
    } catch (e) {
      print(e);
    }
  }
}
