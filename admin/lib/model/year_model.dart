class YearModel {
    int code;
    String status;
    List<Year> data;

    YearModel({
         this.code = 0,
         this.status = "no-status",
         this.data = const [],
    });

    factory YearModel.fromJson(Map<String, dynamic> json) => YearModel(
        code: json["code"],
        status: json["status"],
        data: List<Year>.from(json["data"].map((x) => Year.fromJson(x))),
    );
}

class Year {
    int id;
    String year;
    List<Major> major;

    Year({
         this.id = 0,
         this.year = "no-year",
         this.major = const [],
    });

    factory Year.fromJson(Map<String, dynamic> json) => Year(
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
