class InfoByIdModel {
  int code;
  String status;
  InfoById infoById;

  InfoByIdModel({
    this.code = 0,
    this.status = "no-status",
    required this.infoById,
  });

  factory InfoByIdModel.fromJson(Map<String, dynamic> json) => InfoByIdModel(
        code: json["code"],
        status: json["status"],
        infoById: InfoById.fromJson(json["data"]),
      );
}

class InfoById {
  int id;
  String? name;
  String? codeId;
  String? lat;
  String? long;

  InfoById({
    this.id = 0,
    this.name = "no-name",
    this.codeId = "no-codeId",
    this.lat = "no-lat",
    this.long = "no-long",
  });

  factory InfoById.fromJson(Map<String, dynamic> json) => InfoById(
        id: json["id"],
        name: json["name"],
        codeId: json["codeId"],
        lat: json["lat"],
        long: json["long"],
      );
}
