import 'package:app/models/company.dart';
import 'package:app/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<Rxn<CompanyModel>> companyModelList = RxList<Rxn<CompanyModel>>();
  Rxn<int> companySelected = Rxn<int>();
  RxBool isSelectedConpany = false.obs;
  Rxn<CompanyModel> companyModel = Rxn<CompanyModel>();
  Rxn<String> chosenCompanyUid = Rxn<String>();

  updateCompanyToModel(Rxn<ReservationModel?> model) {
    model.value!.chosenCompany =
        companyModelList[companySelected.value!].value!.uid;
  }

  Future<CompanyModel?> getFirebaseCompanyByUid(String? uid) async {
    CompanyModel? companyModel;

    try {
      if (uid != "") {
        var doc =
            await db.collection('Company').where('uid', isEqualTo: uid).get();

        companyModel = CompanyModel.fromJson(doc.docs[0].data());
        return companyModel;
      }
    } catch (e) {
      return null;
    }
  }

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