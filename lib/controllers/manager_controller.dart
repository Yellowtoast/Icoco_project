import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/models/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManagerController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Rxn<ManagerModel> managerModel = Rxn<ManagerModel>();
  RxList<Rxn<ManagerModel>> managerModelList = RxList<Rxn<ManagerModel>>();
  AuthController authController = Get.find();
  ReviewController reviewController = Get.find();

  @override
  onInit() async {
    if (authController.reservationModel.value != null) {
      await getFirebaseManagerModel(
          authController.reservationModel.value!.reservationNumber,
          authController.reservationModel.value!.managersId);
    }

    super.onInit();
  }

  // Future<RxList<Rxn<ManagerModel>>>
  getFirebaseManagerModel(
      String reservationNumber, List<dynamic>? managerUidList) async {
    try {
      if (reservationNumber != "" && managerUidList != null) {
        for (var managerUid in managerUidList) {
          var doc = await db
              .collection('Manager')
              .where('uid', isEqualTo: managerUid)
              .get();

          Rxn<ManagerModel> model = Rxn<ManagerModel>();
          model.value = ManagerModel.fromJson(doc.docs[0].data());
          managerModelList.add(model);
          managerModelList.refresh();
        }

        // var doc = await db
        //     .collection('Manager')
        //     .where('reservationNumber', isEqualTo: reservationNumber)
        //     .get();
        // doc.docs.forEach((element) {
        //   queryDocumentList.add(element);
        // });
        // queryDocumentList.forEach((element) {
        //   Rxn<ManagerModel> model = Rxn<ManagerModel>();
        //   model.value = ManagerModel.fromJson(element.data());
        //   managerModelList.add(model);
        // });
        // managerModelList.refresh();
      }
    } catch (e) {
      print(e);
    }
  }
}
