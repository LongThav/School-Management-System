class AssignmentModel {
  int code;
  String status;
  Assignment assignment;

  AssignmentModel({
    this.code = 0,
    this.status = "no-status",
    required this.assignment,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        code: json["code"],
        status: json["status"],
        assignment: Assignment.fromJson(json["data"]),
      );
}

class Assignment {
  int id;
  String name;
  String? image;
  List<Assignments> midterm;

  Assignment({
    this.id = 0,
    this.name = "no-name",
    this.image,
    this.midterm = const [],
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        midterm: List<Assignments>.from(
            json["assignment"].map((x) => Assignments.fromJson(x))),
      );
}

class Assignments {
  int id;
  int classId;
  String title;
  String? image;
  String? dateTime;

  Assignments({
    this.id = 0,
    this.classId = 0,
    this.title = "no-title",
    this.dateTime,
    this.image,
  });

  factory Assignments.fromJson(Map<String, dynamic> json) => Assignments(
        id: json["id"],
        classId: json["class_id"],
        title: json["title"],
        image: json["image"],
        dateTime: json["date_time"],
      );
}
