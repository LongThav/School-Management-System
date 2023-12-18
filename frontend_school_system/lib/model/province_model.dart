class ProvincModel {
  int code;
  String status;
  List<Province> data;

  ProvincModel({
    this.code = 0,
    this.status = "no-status",
    this.data = const [],
  });

  factory ProvincModel.fromJson(Map<String, dynamic> json) => ProvincModel(
        code: json["code"],
        status: json["status"],
        data:
            List<Province>.from(json["data"].map((x) => Province.fromJson(x))),
      );
}

class Province {
  int id;
  String nameProvince;

  Province({
    this.id = 0,
    this.nameProvince = 'no-province',
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        nameProvince: json["name_province"],
      );
}
