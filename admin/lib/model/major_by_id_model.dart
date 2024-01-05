class MajorByIdModel {
    int code;
    String status;
    Data data;

    MajorByIdModel({
        required this.code,
        required this.status,
        required this.data,
    });

    factory MajorByIdModel.fromJson(Map<String, dynamic> json) => MajorByIdModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );


}

class Data {
    int id;
    String majorName;
    List<AllClass> allClass;

    Data({
         this.id = 0,
         this.majorName = "no-name",
         this.allClass = const [],
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        majorName: json["major_name"],
        allClass: List<AllClass>.from(json["all_class"].map((x) => AllClass.fromJson(x))),
    );

}

class AllClass {
    int id;
    String? nameClass;

    AllClass({
         this.id = 0,
         this.nameClass,
    });

    factory AllClass.fromJson(Map<String, dynamic> json) => AllClass(
        id: json["id"],
        nameClass: json["name_class"],
    );
}
