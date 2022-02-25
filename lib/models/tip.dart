import 'package:app/configs/constants.dart';

class TipModel {
  String authorId;
  String keyword;
  String title;
  String contents;
  DateTime date;
  List<dynamic> thumbnails;
  List<dynamic> tags;
  String profileImage;

  TipModel({
    required this.authorId,
    required this.keyword,
    required this.title,
    required this.contents,
    required this.date,
    required this.thumbnails,
    required this.tags,
    required this.profileImage,
  });

  factory TipModel.fromJson(Map data) {
    return TipModel(
        authorId: data['authorId'] ?? '관리자',
        keyword: data['keyword'] ?? '',
        title: data['title'] ?? '',
        contents: data['contents'] ?? '',
        date: DateTime.fromMillisecondsSinceEpoch(data['date']),
        thumbnails: data['thumbnails'] ?? [],
        tags: data['tags'] ?? [],
        profileImage: data['profileImage'] ?? emptyProfileUrl);
  }

  Map<String, dynamic> toJson() => {
        "authorId": authorId,
        "keyword": keyword,
        "title": title,
        "contents": contents,
        "date": date.millisecondsSinceEpoch,
        "thumbnails": thumbnails,
        "tags": tags,
      };
}
