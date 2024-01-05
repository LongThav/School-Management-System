class LoginModel {
    String? message;
    int? statusCode;
    Data? data;
    String? role;

    LoginModel({
         this.message,
         this.statusCode,
         this.data,
         this.role,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        role: json["role"] ?? "",
    );
}

class Data {
    String? token;
    User? user;

    Data({
         this.token,
         this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );
}

class User {
    int? id;
    String? email;
    int? roleId;
    User({
         this.id,
         this.email,
         this.roleId,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        roleId: json["role_id"],
    );
}
