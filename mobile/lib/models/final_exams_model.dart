class FinalExamsModel {
  int code;
  String status;
  Finals finals;

  FinalExamsModel({
    this.code = 0,
    this.status = "no-status",
    required this.finals,
  });

  factory FinalExamsModel.fromJson(Map<String, dynamic> json) => FinalExamsModel(
        code: json["code"],
        status: json["status"],
        finals: Finals.fromJson(json["data"]),
      );
}

class Finals {
  int id;
  int classId;
  String dataClass;
  Subjects subjects;
  List<FinalExam> finalExam;

  Finals({
    this.id = 0,
    this.classId = 0,
    this.dataClass = "no-dataclass",
    required this.subjects,
    this.finalExam = const [],
  });

  factory Finals.fromJson(Map<String, dynamic> json) => Finals(
        id: json["id"],
        classId: json["class_id"],
        dataClass: json["class"],
        subjects: Subjects.fromJson(json["subjects"]),
        finalExam: List<FinalExam>.from(json["final_exam"].map((x) => FinalExam.fromJson(x))),
      );
}

class FinalExam {
  int id;
  int classId;
  String title;
  String? image;
  int subjectId;
  String? dateTime;

  FinalExam({
    this.id = 0,
    this.classId = 0,
    this.title = "no-title",
    this.image,
    this.subjectId = 0,
    this.dateTime = "no-datetime",
  });

  factory FinalExam.fromJson(Map<String, dynamic> json) => FinalExam(
        id: json["id"],
        classId: json["class_id"],
        title: json["title"],
        image: json["image"],
        subjectId: json["subject_id"],
        dateTime: json["date_time"],
      );
}

class Subjects {
  String title;
  int classId;

  Subjects({
    this.title = "no-title",
    this.classId = 0,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        title: json["title"],
        classId: json["class_id"],
      );
}
