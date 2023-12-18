class AllTaskInSubjectModel {
  int code;
  String status;
  AllTask allTask;

  AllTaskInSubjectModel({
    this.code = 0,
    this.status = "no-status",
    required this.allTask,
  });

  factory AllTaskInSubjectModel.fromJson(Map<String, dynamic> json) =>
      AllTaskInSubjectModel(
        code: json["code"],
        status: json["status"],
        allTask: AllTask.fromJson(json["data"]),
      );
}

class AllTask {
  int id;
  String name;
  String? image;
  List<Assignments> midterm;
  List<Assignments> quize;
  List<Assignments> assignment;

  AllTask({
    this.id = 0,
    this.name = "no-name",
    this.image,
    this.midterm = const [],
    this.quize = const [],
    this.assignment = const [],
  });

  factory AllTask.fromJson(Map<String, dynamic> json) => AllTask(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        midterm: List<Assignments>.from(
            json["midterm"].map((x) => Assignments.fromJson(x))),
        quize: List<Assignments>.from(
            json["quize"].map((x) => Assignments.fromJson(x))),
        assignment: List<Assignments>.from(
            json["assignment"].map((x) => Assignments.fromJson(x))),
      );
}

class Assignments {
  int id;
  String title;
  String? image;
  String? dateTime;

  Assignments({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.dateTime
  });

  factory Assignments.fromJson(Map<String, dynamic> json) => Assignments(
        id: json["id"],
        title: json["title"],
        dateTime: json["date_time"],
        image: json["image"],
      );
}
