import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String userName;
  final String contents;
  final String managerId;
  final String companyId;

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
    required this.date,
    required this.type,
    required this.specialtyItems,
    this.reviewRate,
    this.thumbnails,
  });

  factory ReviewModel.fromJson(Map data) {
    return ReviewModel(
      userName: data['name'] ?? '',
      contents: data['contents'] ?? '',
      thumbnails: data['thumbnails'] ?? [],
      managerId: data['helperUid'] ?? '',
      companyId: data['companyId'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      type: data['type'],
      specialtyItems: data['specialtyItems'],
      reviewRate: data['reviewRate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": userName,
        "contents": contents,
        "thumbnails": thumbnails,
        "managerId": managerId,
        "companyId": companyId,
        "date": date,
        "type": type,
        "specialtyItems": specialtyItems,
        "reviewRate": reviewRate,
      };
}
