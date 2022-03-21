import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/review_controller.dart';
import 'package:app/helpers/date_calculator.dart';
import 'package:app/models/manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManagerController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Rxn<ManagerModel> managerModel = Rxn<ManagerModel>();
  RxList<Rxn<ManagerModel>> managerModelList = RxList<Rxn<ManagerModel>>();
  AuthController authController = Get.find();

  @override
  onInit() async {
    if (authController.reservationModel.value != null) {
      await getManagerFirestore(
          authController.reservationModel.value!.reservationNumber,
          authController.reservationModel.value!.managersId,
          authController.reservationModel.value!.chosenCompany);
    }

    super.onInit();
  }

  // Future<RxList<Rxn<ManagerModel>>>
  getManagerFirestore(String reservationNumber, List<dynamic>? managerUidList,
      String? chosenCompany) async {
    try {
      if (reservationNumber != "" && managerUidList != null) {
        for (var managerUid in managerUidList) {
          var doc = await db
              .collection('Manager')
              .where('uid', isEqualTo: managerUid)
              .get();

          String companyUid = doc.docs[0].data()['company'];

          var company = await db
              .collection('Company')
              .where('uid', isEqualTo: chosenCompany)
              .get();

          var companyName = await company.docs[0].data()['companyName'];

          Rxn<ManagerModel> managerModel = Rxn<ManagerModel>();

          String birthDate = doc.docs[0].data()['birthDate'];
          String careerStartedDate = doc.docs[0].data()['careerStartedDate'];
          Map<dynamic, dynamic> specialityItems =
              doc.docs[0].data()['specialtyItems'];
          String specialty = doc.docs[0].data()['specialty'];

          managerModel.value = ManagerModel.fromJson({
            'companyName': companyName,
            'ages': calcAges(birthDate),
            'careerYears': calcCareerYears(careerStartedDate),
            'topSpecialty': getTopSpeciality(specialityItems, specialty),
            ...doc.docs[0].data()
          });
          managerModel.value!.managerRate = calcManagerRate(
              managerModel.value!.totalReview,
              managerModel.value!.totalReviewRate);

          managerModelList.add(managerModel);
          managerModelList.refresh();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  applyReviewsToManagerModel(
      List<dynamic> specialites, int reviewRate, int managerNum) {
    print(reviewRate);
    managerModelList[managerNum].value!.totalReviewRate =
        managerModelList[managerNum].value!.totalReviewRate + reviewRate;
    managerModelList[managerNum].value!.totalReview++;
    if (specialites.isNotEmpty) {
      specialites.forEach((specialty) {
        managerModelList[managerNum].value!.specialtyItems![specialty]++;
      });
    }

    updateManagerFirestore(managerModelList[managerNum].value);
  }

  changeReviewsToManagerModel(List<dynamic> specialitesBefore,
      List<dynamic> specialitesAfter, int changedRate, int managerNum) {
    print(changedRate);
    managerModelList[managerNum].value!.totalReviewRate =
        managerModelList[managerNum].value!.totalReviewRate + changedRate;

    if (specialitesBefore.isNotEmpty) {
      specialitesBefore.forEach((specialty) {
        managerModelList[managerNum].value!.specialtyItems![specialty]--;
      });
    }
    if (specialitesAfter.isNotEmpty) {
      specialitesAfter.forEach((specialty) {
        managerModelList[managerNum].value!.specialtyItems![specialty]++;
      });
    }

    updateManagerFirestore(managerModelList[managerNum].value);
  }

  void updateManagerFirestore(ManagerModel? manager) {
    db.doc('/Manager/${manager!.uid}').update(manager.toJson());
    update();
  }

  calcManagerRate(int? totalReview, int? totalRate) {
    int managerRate = 0;
    if (totalReview != null && totalRate != null && totalRate != 0) {
      managerRate = totalRate ~/ totalReview;
    }
    return managerRate;
  }

  int calcAges(String birthDate) {
    int age = calcYearFromNow(birthDate);
    if (age > 10) {
      age = age ~/ 10 * 10;
    }
    return age;
  }

  int calcCareerYears(String careerStartDate) {
    int careerYear = calcYearFromNow(careerStartDate);
    return careerYear;
  }

  getTopSpeciality(Map<dynamic, dynamic> specialtyItems, String specialty) {
    String topSpeciality = '산모케어';
    int itemNum = 0;
    specialtyItems.forEach((key, value) {
      if (value > itemNum) {
        topSpeciality = key;
        itemNum = value;
      }
    });
    if (itemNum == 0) {
      topSpeciality = specialty;
    }

    return topSpeciality;
  }
}
