import 'package:app/models/company.dart';
import 'package:app/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<Rxn<CompanyModel>> companyModelList = RxList<Rxn<CompanyModel>>();
  Rxn<int> companySelected = Rxn<int>();
  RxBool isSelectedConpany = false.obs;

  // RxList<Map<String, String?>> companyList = RxList<Map<String, String?>>([
  //   {"title": "디어케어", "address": "대구 남구 남산로 45"},
  //   {"title": "친정맘", "address": "대구 남구 남산로 45"},
  //   {"title": "단하루 산후도우미", "address": "대구 남구 남산로 45"},
  //   {"title": "업체는 상관없어요", "address": null},
  // ]);

  updateCompanyToModel(Rxn<ReservationModel?> model) {
    model.value!.chosenCompany =
        companyModelList[companySelected.value!].value!.uid;
  }

  // getFirebaseComapnyModel(String reservationNumber) async {
  //   List<dynamic> queryDocumentList = [];
  //   RxList<Rxn<ManagerModel>> modelList = RxList<Rxn<ManagerModel>>();
  //   try {
  //     if (reservationNumber != "") {
  //       var doc = await db
  //           .collection('Manager')
  //           .where('reservationNumber', isEqualTo: reservationNumber)
  //           .get();
  //       doc.docs.forEach((element) {
  //         queryDocumentList.add(element);
  //       });
  //       queryDocumentList.forEach((element) {
  //         Rxn<ManagerModel> model = Rxn<ManagerModel>();
  //         model.value = ManagerModel.fromJson(element.data());
  //         managerModelList.add(model);
  //       });
  //       managerModelList.refresh();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<CompanyModel?> getCompanyAllDocsFirebase(String uid) async {
  //   RxList<Rxn<CompanyModel>> allCompanyList = RxList<Rxn<CompanyModel>>();

  //   try {
  //     if (uid != "") {
  //       var doc = await db
  //           .collection('Reservation')
  //           .where('uid', isEqualTo: uid)
  //           .get();
  //       print(doc.docs[0].data());
  //       reservationModel = ReservationModel.fromJson(doc.docs[0].data());
  //       return reservationModel;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

// FirebaseFirestore.instance
//     .collection('users')
//     .get()
//     .then((QuerySnapshot querySnapshot) {
//         querySnapshot.docs.forEach((doc) {
//             print(doc["first_name"]);
//         });
//     });
  //  (documentSnapshot) => UserModel.fromJson(documentSnapshot.data()!));
  Future<CompanyModel?> getCompanyAllDocsFirebase() async {
    List<dynamic> queryDocumentList = [];
    RxList<Rxn<CompanyModel>> allCompanyList = RxList<Rxn<CompanyModel>>();
    try {
      var doc = await db
          .collection('Company')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          queryDocumentList.add(doc);
        });
        queryDocumentList.forEach((element) {
          Rxn<CompanyModel> model = Rxn<CompanyModel>();
          model.value = CompanyModel.fromJson(element.data());
          companyModelList.add(model);
        });
        companyModelList.refresh();
      });
    } catch (e) {
      print(e);
    }
  }
}
