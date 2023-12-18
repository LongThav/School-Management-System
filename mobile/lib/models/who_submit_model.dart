class WhoSubmitModel {
  int code;
  String status;
  WhoSubmit data;

  WhoSubmitModel({
    this.code = 0,
    this.status = "no-status",
    required this.data,
  });

  factory WhoSubmitModel.fromJson(Map<String, dynamic> json) => WhoSubmitModel(
        code: json["code"],
        status: json["status"],
        data: WhoSubmit.fromJson(json["data"]),
      );
}

class WhoSubmit {
  int id;
  String username;
  String email;
  String image;
  CodeId codeId;

  WhoSubmit({
    this.id = 0,
    this.username = "no-username",
    this.email = "no-email",
    this.image = "no-image",
    required this.codeId,
  });

  factory WhoSubmit.fromJson(Map<String, dynamic> json) => WhoSubmit(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
        codeId: CodeId.fromJson(json["code_Id"]),
      );
}

class CodeId {
  String codeId;

  CodeId({
    this.codeId = "no-code",
  });

  factory CodeId.fromJson(Map<String, dynamic> json) => CodeId(
        codeId: json["codeId"],
      );
}
