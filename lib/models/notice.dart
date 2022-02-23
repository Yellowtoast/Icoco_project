class NoticeModel {
  String title;
  String subtitle;
  String contents;
  String? thumbnail;
  DateTime date;

  NoticeModel({
    required this.title,
    required this.subtitle,
    required this.contents,
    required this.thumbnail,
    required this.date,
  });

  factory NoticeModel.fromJson(Map data) {
    return NoticeModel(
      subtitle: data['subtitle'] ?? '',
      title: data['title'] ?? '',
      contents: data['contents'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "contents": contents,
        "thumbnail": thumbnail,
        "date": date.millisecondsSinceEpoch,
      };
}
