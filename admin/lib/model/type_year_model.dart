class TypeYearModel {
    int code;
    String status;
    List<TypeYear> data;

    TypeYearModel({
         this.code = 0,
         this.status = "no-status",
         this.data = const [],
    });

    factory TypeYearModel.fromJson(Map<String, dynamic> json) => TypeYearModel(
        code: json["code"],
        status: json["status"],
        data: List<TypeYear>.from(json["data"].map((x) => TypeYear.fromJson(x))),
    );
}

class TypeYear {
    int id;
    String year;
    List<Major> major;

    TypeYear({
         this.id = 0,
         this.year = "no-year",
         this.major = const [],
    });

    factory TypeYear.fromJson(Map<String, dynamic> json) => TypeYear(
        id: json["id"],
        year: json["year"],
        major: List<Major>.from(json["major"].map((x) => Major.fromJson(x))),
    );
}

class Major {
    int id;
    String majorName;
    int yearId;

    Major({
         this.id = 0,
         this.majorName = "no-name",
         this.yearId = 0,
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        majorName: json["major_name"],
        yearId: json["year_id"],
    );
}
