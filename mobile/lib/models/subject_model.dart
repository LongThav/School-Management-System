class SubJectModel {
  int code;
  String status;
  Data data;

  SubJectModel({
    this.code = 0,
    this.status = "no-status",
    required this.data,
  });

  factory SubJectModel.fromJson(Map<String, dynamic> json) => SubJectModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int id;
  String className;
  String allClass;
  List<Subject> subject;

  Data({
    this.id = 0,
    this.className = "no-name",
    this.allClass = "no-allclass",
    this.subject = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        className: json["class_name"],
        allClass: json["all_class"],
        subject:
            List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
      );
}

class Subject {
  int id;
  int classId;
  String title;
  String? image;

  Subject({
    this.id = 0,
    this.classId = 0,
    this.title = "no-title",
    this.image,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        classId: json["class_id"],
        title: json["title"],
        image: json["image"],
      );
}
