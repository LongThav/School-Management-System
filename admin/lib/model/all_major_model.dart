class AllMajorModel {
    int code;
    String status;
    List<Major> data;

    AllMajorModel({
         this.code = 0,
         this.status = "no-status",
         this.data = const [],
    });

    factory AllMajorModel.fromJson(Map<String, dynamic> json) => AllMajorModel(
        code: json["code"],
        status: json["status"],
        data: List<Major>.from(json["data"].map((x) => Major.fromJson(x))),
    );
}

class Major {
    int id;
    String majorName;
    List<AllClass> allClass;

    Major({
         this.id = 0,
         this.majorName = "no-major",
         this.allClass = const [],
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        majorName: json["major_name"],
        allClass: List<AllClass>.from(json["all_class"].map((x) => AllClass.fromJson(x))),
    );
}

class AllClass {
    int id;
    String nameClass;
    int majorId;

    AllClass({
         this.id = 9,
         this.nameClass = "no-className",
         this.majorId = 0,
    });

    factory AllClass.fromJson(Map<String, dynamic> json) => AllClass(
        id: json["id"],
        nameClass: json["name_class"],
        majorId: json["major_id"],
    );
}
