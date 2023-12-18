// class ClassModel {
//     int code;
//     String status;
//     List<Province> data;

//     ClassModel({
//          this.code = 0,
//          this.status = "no-status",
//          this.data = const [],
//     });

//     factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
//         code: json["code"],
//         status: json["status"],
//         data: List<Province>.from(json["data"].map((x) => Province.fromJson(x))),
//     );

// }

// class Province {
//     int id;
    
//     String? nameClass;
    

//     Province({
//          this.id = 0,
//          this.nameClass,
//     });

//     factory Province.fromJson(Map<String, dynamic> json) => Province(
//         id: json["id"],
//         nameClass: json["name_class"],
//     );
// }

// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

class ClassModel {
    int code;
    String status;
    List<Classs> data;

    ClassModel({
         this.code = 0,
         this.status = "no-status",
         this.data = const [],
    });

    factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        code: json["code"],
        status: json["status"],
        data: List<Classs>.from(json["data"].map((x) => Classs.fromJson(x))),
    );

}

class Classs {
    int id;
    String className;
    String allClass;
    int? majorId;
    int? studentId;

    Classs({
         this.id = 0,
         this.className = "no-classname",
         this.allClass = "no-allclass",
         this.majorId,
         this.studentId,
    });

    factory Classs.fromJson(Map<String, dynamic> json) => Classs(
        id: json["id"],
        className: json["class_name"],
        allClass: json["all_class"],
        majorId: json["major_id"],
        studentId: json["student_id"],
    );
}


