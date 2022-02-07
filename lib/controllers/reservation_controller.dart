// import 'package:app/controllers/auth_controller.dart';
// import 'package:app/controllers/home_controller.dart';
// import 'package:app/helpers/format.dart';
// import 'package:app/models/reservation.dart';
// import 'package:app/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class ReservationController extends GetxController {
//   Rxn<ReservationModel?> reservationModel = Rxn<ReservationModel>();
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   Rxn<UserModel> userModel = Rxn<UserModel>();
//   Rxn<String> reservationNumber = Rxn<String>();
//   HomeController homeController = HomeController();

//   @override
//   void onInit() async {
//     // setReservationModel();
//     super.onInit();
//   }

//   @override
//   void onReady() async {
//     // setReservationModel();
//     super.onReady();
//   }

//   // setReservationModel() {
//   //   if (reservationModel.value == null) {
//   //     homeController = Get.find();
//   //     reservationModel = homeController.reservationModel;
//   //     reservationNumber.value =
//   //         homeController.reservationModel.value!.reservationNumber;
//   //   }
//   // }

//   // Stream<ReservationModel> streamFirestoreReservation() {
//   //   print('streamFirestoreReservation()');
//   //   return db
//   //       .doc('/Reservation/${reservationNumber.value}')
//   //       .snapshots()
//   //       .map((snapshot) => ReservationModel.fromJson(snapshot.data()!));
//   // }

//   // Future<void> createReservationFirestore(dynamic model) async {
//   //   reservationNumber.value =
//   //       dateFormatForReservatioNumber.format(DateTime.now());
//   //   ReservationModel _newReservationModel = ReservationModel(
//   //     address: '',
//   //     email: model.email,
//   //     isMarketingAllowed: model.isMarketingAllowed,
//   //     userName: model.userName,
//   //     phone: model.phone,
//   //     fullRegNum: '',
//   //     uid: model.uid,
//   //     userStep: model.userStep,
//   //     date: DateTime.now().millisecondsSinceEpoch,
//   //     reservationNumber: reservationNumber.value!,
//   //     reservationRoute: '앱',
//   //     isFinishedBalance: '입금 전',
//   //     isFinishedDeposit: '입금 전',
//   //   );
//   //   reservationModel.value = _newReservationModel;

//   //   db
//   //       .doc('/Reservation/${reservationNumber.value}')
//   //       .set(_newReservationModel.toJson());
//   //   update();
//   // }

//   // setUserStep(int currentStep) {
//   //   reservationModel.value!.userStep = currentStep;
//   // }

//   // updateReservationFirestore(String reservationNumber) async {
//   //   db.doc('/Reservation/$reservationNumber').set(reservationModel.toJson());
//   //   update();
//   // }

//   // Future<ReservationModel?> getFirebaseReservationModel(
//   //     reservationNumber) async {
//   //   if (reservationNumber == null) {
//   //     return null;
//   //   }

//   //   return db.doc('/Reservation/$reservationNumber').get().then(
//   //       (documentSnapshot) =>
//   //           ReservationModel.fromJson(documentSnapshot.data()!));
//   // }
// }
