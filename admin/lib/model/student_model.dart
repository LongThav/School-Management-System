class StudentModel {
  int code;
  String status;
  Data data;

  StudentModel({
    this.code = 0,
    this.status = 'no-statue',
    required this.data,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int id;
  String? className;
  String? allClass;
  List<Student> students;

  Data({
    this.id = 0,
    this.className,
    this.allClass,
    this.students = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        className: json["class_name"],
        allClass: json["all_class"],
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
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
  int? subjectId;
  String? sangkat;
  String? image;
  String? payment;
  String? country;
  String? role;
  String? phone;
  int? idClass;

  Student({
    this.id = 9,
    this.name,
    this.codeId,
    this.age,
    this.sex,
    this.city,
    this.khan,
    this.subjectId,
    this.payment = 'no-payment',
    this.role,
    this.sangkat,
    this.image,
    this.country,
    this.phone,
    this.idClass,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        codeId: json["codeId"],
        age: json["age"],
        sex: json["sex"] ?? "",
        city: json["city"],
        role: json["role"],
        khan: json["khan"],
        payment: json['payment'],
        sangkat: json["sangkat"],
        image: json["image"],
        country: json["country"],
        subjectId: json["subject_id"],
        phone: json["phone"],
        idClass: json["id_class"],
      );
}
