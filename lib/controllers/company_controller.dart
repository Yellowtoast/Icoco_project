import 'package:app/controllers/voucher_controller.dart';
import 'package:app/models/company.dart';
import 'package:app/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<CompanyModel> companyModelList = RxList<CompanyModel>();
  Rxn<int> companySelected = Rxn<int>();
  RxBool isSelectedConpany = false.obs;
  Rxn<CompanyModel> companyModel = Rxn<CompanyModel>();
  Rx<String> chosenCompanyUid = ''.obs;

  @override
  void onReady() {
    ever(companySelected, (_) {
      VoucherController voucherController = Get.find();
      voucherController.companyUid.value =
          companyModelList[companySelected.value!].uid!;
    });
    super.onReady();
  }

  updateCompanyToModel(Rxn<ReservationModel?> model) {
    model.value!.chosenCompany = companyModelList[companySelected.value!].uid;
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

  getCompanyAllDocsFirebase() async {
    List<dynamic> queryDocumentList = [];
    RxList<CompanyModel> allCompanyList = RxList<CompanyModel>();
    companyModelList.clear();
    try {
      var doc = await db
          .collection('Company')
          .where('isInfoFilled', isEqualTo: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          queryDocumentList.add(doc);
        });
        queryDocumentList.forEach((element) {
          companyModelList.add(CompanyModel.fromJson(element.data()));
        });
        companyModelList.refresh();
      });
    } catch (e) {
      print(e);
    }
  }
}
