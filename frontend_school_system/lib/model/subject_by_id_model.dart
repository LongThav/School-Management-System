class SubjectByIdModel {
  int code;
  String status;
  Data data;

  SubjectByIdModel({
    this.code = 0,
    this.status = "no-status",
    required this.data,
  });

  factory SubjectByIdModel.fromJson(Map<String, dynamic> json) =>
      SubjectByIdModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int id;
  int classId;
  String dataClass;
  Subjects subjects;

  Data({
    this.id = 0,
    this.classId = 0,
    this.dataClass = "no-dataclass",
    required this.subjects,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        classId: json["class_id"],
        dataClass: json["class"],
        subjects: Subjects.fromJson(json["subjects"]),
      );
}

class Subjects {
  String title;
  int classId;
  List<Person> person;

  Subjects({
    this.title = "no-title",
    this.classId = 0,
    this.person = const [],
  });

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        title: json["title"],
        classId: json["class_id"],
        person:
            List<Person>.from(json["person"].map((x) => Person.fromJson(x))),
      );
}

class Person {
  int id;
  String? name;
  String codeId;
  String age;
  String? sex;
  String city;
  String khan;
  String sangkat;
  int personId;
  String? image;
  String country;
  String? payment;
  String phone;
  String? role;

  Person({
    this.id = 0,
    this.name = "no-name",
    this.codeId = "no-codeId",
    this.age = "no-age",
    this.sex,
    this.city = "no-city",
    this.khan = "no-khan",
    this.payment,
    this.sangkat = "no-sangkat",
    this.personId = 0,
    this.image,
    this.country = "no-image",
    this.phone = "no-phone",
    this.role,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        codeId: json["codeId"],
        age: json["age"],
        sex: json["sex"],
        city: json["city"],
        khan: json["khan"],
        sangkat: json["sangkat"],
        personId: json["person_id"],
        payment: json["payment"],
        image: json["image"],
        country: json["country"],
        phone: json["phone"],
        role: json["role"],
      );
}
