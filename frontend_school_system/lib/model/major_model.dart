class MajorModel {
    int code;
    String status;
    List<Major> data;

    MajorModel({
         this.code = 0,
         this.status = "no-status",
         this.data = const [],
    });

    factory MajorModel.fromJson(Map<String, dynamic> json) => MajorModel(
        code: json["code"],
        status: json["status"],
        data: List<Major>.from(json["data"].map((x) => Major.fromJson(x))),
    );
}

class Major {
    int id;
    String majorName;
   

    Major({
         this.id = 0,
         this.majorName = "no-major",
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        majorName: json["major_name"],
    );

}
