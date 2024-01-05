class UserModel {
  int code;
  String status;
  List<User> data;

  UserModel({
    this.code = 0,
    this.status = "no-status",
    this.data = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        status: json["status"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );
}

class User {
  int id;
  bool selected;
  String email;
  String? username;
  UserInfor? userInfor;
  Class? className;
  Gender? gender;
  Role? role;

  User({
    this.id = 0,
    this.gender,
    this.selected = false,
    this.username,
    this.email = "no-email",
    this.userInfor,
    this.className,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        className: Class.fromJson(json["class"]),
        userInfor: json["user_infor"] == null
            ? null
            : UserInfor.fromJson(json["user_infor"]),
        role: Role.fromJson(json["role"]),
        gender: json["gender"] == null ? null : Gender.fromJson(json["gender"]),
      );
}

class Role {
  int id;
  String role;

  Role({
    this.id = 0,
    this.role = "no-role",
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        role: json["role"],
      );
}

class UserInfor {
  int id;
  String? name;
  String codeId;
  String age;
  String? sex;
  String city;
  String khan;
  String sangkat;
  String? image;
  String country;
  String phone;

  UserInfor({
    this.id = 0,
    this.name,
    this.codeId = "no-codeId",
    this.age = "no-age",
    this.sex = "no-sex",
    this.city = "no-city",
    this.khan = "no-Khan",
    this.sangkat = "no-sangkat",
    this.image,
    this.country = "no-coutry",
    this.phone = "no-phone",
  });

  factory UserInfor.fromJson(Map<String, dynamic> json) => UserInfor(
        id: json["id"],
        name: json["name"] ?? "",
        codeId: json["codeId"],
        age: json["age"],
        sex: json["sex"],
        city: json["city"],
        khan: json["khan"],
        sangkat: json["sangkat"],
        image: json["image"],
        country: json["country"],
        phone: json["phone"],
      );
}

class Gender {
  int id;
  String sex;

  Gender({
    required this.id,
    required this.sex,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        sex: json["sex"],
      );
}


class Class {
    int id;
    String? nameClass;

    Class({
         this.id = 0,
         this.nameClass = "no-class",
    });

    factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        nameClass: json["name_class"],
    );
}
