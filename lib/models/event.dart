class EventModel {
  String id;
  String appBanner;
  String author;
  String contents;
  int date;
  String detailThumbnail;
  String startDate;
  String endDate;
  bool moveTo;
  String status;
  String thumbnail;
  String title;

  EventModel({
    required this.id,
    required this.appBanner,
    required this.author,
    required this.contents,
    required this.date,
    required this.detailThumbnail,
    required this.startDate,
    required this.endDate,
    required this.moveTo,
    required this.status,
    required this.thumbnail,
    required this.title,
  });

  factory EventModel.fromJson(Map data) {
    return EventModel(
      id: data['id'],
      appBanner: data['appBanner'] ?? '',
      author: data['author'] ?? '',
      contents: data['contents'] ?? '',
      date: data['date'] ?? 0,
      detailThumbnail: data['detailThumbnail'] ?? '',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      moveTo: data['moveTo'] ?? true,
      status: data['status'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "appBanner": appBanner,
        "author": author,
        "contents": contents,
        "date": date,
        "detailThumbnail": detailThumbnail,
        "startDate": startDate,
        "endDate": endDate,
        "moveTo": moveTo,
        "status": status,
        "thumbanil": thumbnail,
        "title": title,
      };
}
