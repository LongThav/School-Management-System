class EventModel {
  int code;
  String status;
  List<Event> event;

  EventModel({
    this.code = 0,
    this.status = "no-status",
    this.event = const [],
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        code: json["code"],
        status: json["status"],
        event: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
      );
}

class Event {
  int id;
  String? eventTitle;
  String? image;
  String? dateTime;

  Event({
    this.id = 0,
    this.eventTitle,
    this.image,
    this.dateTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(id: json["id"], eventTitle: json["event_title"], image: json["image"], dateTime: json["date_time"]);
}
