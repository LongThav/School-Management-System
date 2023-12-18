class LoginModel {
  String message;
  int statusCode;
  Data data;
  String role;
  int roleId;

  LoginModel({
    this.message = "no-message",
    this.statusCode = 0,
    required this.data,
    this.role = "no-role",
    this.roleId = 0,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        role: json["role"],
        roleId: json["role_id"],
      );
}

class Data {
  String token;
  User user;
  Info info;

  Data({
    this.token = "no-token",
    required this.user,
    required this.info,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        info: Info.fromJson(json["info"]),
        user: User.fromJson(json["user"]),
      );
}

class User {
  int id;
  String username;
  String? userCode;
  String? personId;
  String? userId;
  String? role;
  int genderId;
  String email;
  int roleId;
  String? image;

  User({
    this.id = 0,
    this.username = "no-username",
    this.userCode,
    this.personId,
    this.userId,
    this.role,
    this.genderId = 0,
    this.email = "no-email",
    this.roleId = 0,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        userCode: json["user_code"],
        personId: json["person_id"],
        userId: json["user_id"],
        role: json["role"],
        genderId: json["gender_id"],
        email: json["email"],
        roleId: json["role_id"],
        image: json["image"],
      );
}

class Info {
  int? id;
  int? genderId;
  String? username;
  String? email;
  UserInfor? userInfor;
  String? image;
  Class? infoClass;
  int? yearId;

  Info({
    this.id,
    this.genderId,
    this.username,
    this.email,
    this.userInfor,
    this.image,
    this.infoClass,
    this.yearId,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        genderId: json["gender_id"],
        infoClass: Class.fromJson(json["class"]),
        username: json["username"],
        email: json["email"],
        userInfor: UserInfor.fromJson(json["user_infor"]),
        image: json["image"],
        yearId: json["year_id"],
      );
}

class Class {
  int id;
  String nameClass;
  int majorId;

  Class({
    required this.id,
    required this.nameClass,
    required this.majorId,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        nameClass: json["name_class"],
        majorId: json["major_id"],
      );
}

class UserInfor {
  int? id;
  String? name;
  String? codeId;
  String? age;
  String? sex;
  String? city;
  String? khan;
  String? sangkat;
  int? userId;
  int? personId;
  String? image;
  String? country;
  String? phone;
  int? idClass;
  String? role;
  String? payment;
  int? majorId;
  dynamic statusId;
  int? yearId;
  Class? getClass;

  UserInfor({
    this.id,
    this.name,
    this.codeId,
    this.age,
    this.sex,
    this.city,
    this.khan,
    this.sangkat,
    this.userId,
    this.personId,
    this.image,
    this.country,
    this.phone,
    this.idClass,
    this.role,
    this.payment,
    this.majorId,
    this.statusId,
    this.yearId,
    this.getClass,
  });

  factory UserInfor.fromJson(Map<String, dynamic> json) => UserInfor(
        id: json["id"],
        name: json["name"],
        codeId: json["codeId"],
        age: json["age"],
        sex: json["sex"],
        city: json["city"],
        khan: json["khan"],
        sangkat: json["sangkat"],
        userId: json["user_id"],
        personId: json["person_id"],
        image: json["image"],
        country: json["country"],
        phone: json["phone"],
        idClass: json["id_class"],
        role: json["role"],
        payment: json["payment"],
        majorId: json["major_id"],
        statusId: json["status_id"],
        yearId: json["year_id"],
        getClass: Class.fromJson(json["get_class"]),
      );
}
