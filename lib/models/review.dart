import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String userName;
  String contents;
  final String managerId;
  final String companyId;
  final String userId;
  final String type;
  final List<dynamic>? specialtyItems;
  List<dynamic>? thumbnails;
  int? reviewRate;
  DateTime date;

  ReviewModel({
    required this.userName,
    required this.contents,
    required this.managerId,
    required this.companyId,
    required this.userId,
    required this.date,
    required this.type,
    required this.specialtyItems,
    this.reviewRate,
    this.thumbnails,
  });

  factory ReviewModel.fromJson(Map data) {
    return ReviewModel(
      userName: data['userName'] ?? '',
      contents: data['contents'] ?? '',
      thumbnails: data['thumbnails'] ?? [],
      managerId: data['managerId'] ?? '',
      companyId: data['companyId'] ?? '',
      userId: data['userId'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      // date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      type: data['type'] ?? '',
      specialtyItems: data['specialtyItems'] ?? [],
      reviewRate: data['reviewRate'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "contents": contents,
        "thumbnails": thumbnails,
        "userId": userId,
        "managerId": managerId,
        "companyId": companyId,
        "date": date.millisecondsSinceEpoch,
        "type": type,
        "specialtyItems": specialtyItems,
        "reviewRate": reviewRate,
      };
}
