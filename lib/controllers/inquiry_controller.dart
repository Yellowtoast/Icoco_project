import 'dart:io';
import 'package:app/configs/purplebook.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/manager_controller.dart';
import 'package:app/models/inquiry.dart';
import 'package:app/models/manager.dart';
import 'package:app/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class InquiryController extends GetxController {
  TextEditingController contentsTextController = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Rx<String> reviewContents = ''.obs;

  createInquiryFirestore(
      String companyId, String userId, List<dynamic> managersId) {
    InquiryModel _newInquiryModel = InquiryModel(
        companyId: companyId,
        contents: reviewContents.value,
        date: DateTime.now(),
        managersId: managersId,
        userId: userId);

    db.collection('Question').add(_newInquiryModel.toJson());
    update();
  }
}
