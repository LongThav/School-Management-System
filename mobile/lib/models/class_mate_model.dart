class ClassMateModel {
  int? code;
  String? status;
  Data? data;

  ClassMateModel({
    this.code,
    this.status,
    this.data,
  });

  factory ClassMateModel.fromJson(Map<String, dynamic> json) => ClassMateModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int? id;
  String? className;
  String? allClass;
  int? majorId;
  List<Student>? students;
  AllExam? allExam;
  List<dynamic>? subect;

  Data({
    this.id,
    this.className,
    this.allClass,
    this.majorId,
    this.students,
    this.allExam,
    this.subect,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        className: json["class_name"],
        allClass: json["all_class"],
        majorId: json["major_id"],
        students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
        allExam: AllExam.fromJson(json["all_exam"]),
        subect: List<dynamic>.from(json["subect"].map((x) => x)),
      );
}

class AllExam {
  List<FinalExam> finalExam;
  List<dynamic> midtermExam;
  List<dynamic> quiz;
  List<dynamic> assignment;

  AllExam({
    this.finalExam = const [],
    this.midtermExam = const [],
    this.quiz = const [],
    this.assignment = const [],
  });

  factory AllExam.fromJson(Map<String, dynamic> json) => AllExam(
        finalExam: List<FinalExam>.from(json["final_exam"].map((x) => FinalExam.fromJson(x))),
        midtermExam: List<dynamic>.from(json["midterm_exam"].map((x) => x)),
        quiz: List<dynamic>.from(json["quiz"].map((x) => x)),
        assignment: List<dynamic>.from(json["assignment"].map((x) => x)),
      );
}

class FinalExam {
  int? id;
  int? classId;
  String? title;

  FinalExam({
    this.id,
    this.classId,
    this.title,
  });

  factory FinalExam.fromJson(Map<String, dynamic> json) => FinalExam(
        id: json["id"],
        classId: json["class_id"],
        title: json["title"],
      );
}

class Student {
  int id;
  String? name;
  String? codeId;
  String? age;
  String? sex;
  String? city;
  String? khan;
  String? sangkat;
  int? userId;
  int? personId;
  String? image;
  String? country;
  String? phone;
  int? idClass;
  String? role;
  String? payment;
  int? majorId;
  int? yearId;
  String? lat;
  String? long;
  int? subjectId;

  Student({
    this.id = 0,
    this.name,
    this.codeId,
    this.age,
    this.sex,
    this.city,
    this.khan,
    this.sangkat,
    this.userId,
    this.personId,
    this.image,
    this.country,
    this.phone,
    this.idClass,
    this.role,
    this.payment,
    this.majorId,
    this.lat,
    this.long,
    this.yearId,
    this.subjectId,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        codeId: json["codeId"],
        age: json["age"],
        sex: json["sex"],
        city: json["city"],
        khan: json["khan"],
        sangkat: json["sangkat"],
        userId: json["user_id"],
        personId: json["person_id"],
        image: json["image"],
        country: json["country"],
        phone: json["phone"],
        idClass: json["id_class"],
        role: json["role"],
        payment: json["payment"],
        lat: json["lat"],
        long: json["long"],
        majorId: json["major_id"],
        yearId: json["year_id"],
        subjectId: json["subject_id"],
      );
}
