class ClassByModorIdModel {
    int code;
    String status;
    Data data;

    ClassByModorIdModel({
         this.code = 0,
         this.status = "no-status",
         required this.data,
    });

    factory ClassByModorIdModel.fromJson(Map<String, dynamic> json) => ClassByModorIdModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );
}

class Data {
    int id;
    String majorName;
    List<AllClass> allClass;
    Year year;
    int yearId;
    List<AllClass> allClassByMajor;
    int classId;
    List<AllStudent> allStudent;

    Data({
         this.id = 0,
         this.majorName = "no-name",
         this.allClass = const [],
         required this.year,
         this.yearId = 0,
         this.allClassByMajor = const [],
         this.classId = 0,
         this.allStudent = const [],
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        majorName: json["major_name"],
        allClass: List<AllClass>.from(json["all_class"].map((x) => AllClass.fromJson(x))),
        year: Year.fromJson(json["year"]),
        yearId: json["year_id"],
        allClassByMajor: List<AllClass>.from(json["all_class_by_major"].map((x) => AllClass.fromJson(x))),
        classId: json["class_id"],
        allStudent: List<AllStudent>.from(json["all_student"].map((x) => AllStudent.fromJson(x))),
    );
}

class AllClass {
    int id;
    String nameClass;
    int? idClass;
    int? majorId;

    AllClass({
         this.id = 0, 
         this.nameClass = "no-class",
         this.idClass,
         this.majorId,
    });

    factory AllClass.fromJson(Map<String, dynamic> json) => AllClass(
        id: json["id"],
        nameClass: json["name_class"],
        idClass: json["id_class"],
        majorId: json["major_id"],
    );
}

class AllStudent {
    int id;
    String name;
    String codeId;
    String age;
    String city;
    String khan;
    String sangkat;
    dynamic image;
    String country;
    String phone;
    int idClass;
    String? payment;
    int majorId;
    int yearId;

    AllStudent({
         this.id = 0,
         this.name = "no-name",
         this.codeId = "no-code",
         this.age = "no-age",
         this.city = "no-city",
         this.khan = "no-khan",
         this.sangkat = "no-sangkat",
         this.image,
         this.country = "no-country",
         this.phone = "no-phone",
         this.idClass = 0,
         this.payment,
         this.majorId = 0,
         this.yearId = 0,
    });

    factory AllStudent.fromJson(Map<String, dynamic> json) => AllStudent(
        id: json["id"],
        name: json["name"],
        codeId: json["codeId"],
        age: json["age"],
        city: json["city"],
        khan: json["khan"],
        sangkat: json["sangkat"],
        image: json["image"],
        country: json["country"],
        phone: json["phone"],
        idClass: json["id_class"],
        payment: json["payment"],
        majorId: json["major_id"],
        yearId: json["year_id"],
    );

}

class Year {
    int id;
    String year;
    int idClass;
    List<AllClass> getAllClass;
    List<AllStudent> getAllStudent;

    Year({
         this.id = 9,
         this.year = "no-year",
         this.idClass = 0,
         this.getAllClass = const [],
         this.getAllStudent = const [],
    });

    factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"],
        year: json["year"],
        idClass: json["id_class"],
        getAllClass: List<AllClass>.from(json["get_all_class"].map((x) => AllClass.fromJson(x))),
        getAllStudent: List<AllStudent>.from(json["get_all_student"].map((x) => AllStudent.fromJson(x))),
    );
}
