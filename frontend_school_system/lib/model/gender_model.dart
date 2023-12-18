class GenderModel {
    int code;
    String status;
    List<Gender> data;

    GenderModel({
         this.code = 0,
         this.status = 'no-status',
         this.data = const [],
    });

    factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        code: json["code"],
        status: json["status"],
        data: List<Gender>.from(json["data"].map((x) => Gender.fromJson(x))),
    );
}

class Gender {
    int id;
    String? sex;

    Gender({
         this.id = 0,
         this.sex = 'no-sex',
    });

    factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        sex: json["sex"],
    );
}
