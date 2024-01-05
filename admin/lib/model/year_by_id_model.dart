class YearByIdModel {
    int code;
    String status;
    Data data;

    YearByIdModel({
         this.code = 0,
         this.status = "no-status",
         required this.data,
    });

    factory YearByIdModel.fromJson(Map<String, dynamic> json) => YearByIdModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );
}

class Data {
    int id;
    String year;
    List<Major> major;

    Data({
         this.id = 0,
         this.year = "no-year",
         this.major = const [],
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
         this.majorName = "no-majorName",
         this.yearId = 0,
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        majorName: json["major_name"],
        yearId: json["year_id"],
    );
}
