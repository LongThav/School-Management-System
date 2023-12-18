class AdminSignUpModel {
  int? code;
  String? status;
  Data? data;

  AdminSignUpModel({
    this.code,
    this.status,
    this.data,
  });

  factory AdminSignUpModel.fromJson(Map<String, dynamic> json) =>
      AdminSignUpModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? accessToken;
  User? user;

  Data({
    required this.accessToken,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );
}

class User {
  String? email;
  String? roleId;
  int? id;

  User({
    this.email,
    this.roleId,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        roleId: json["role_id"],
        id: json["id"],
      );
}
