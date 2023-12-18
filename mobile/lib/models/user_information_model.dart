class UserInformationModel {
  int code;
  String status;
  UserById? data;

  UserInformationModel({
    this.code = 0,
    this.status = "no-state",
    this.data,
  });

  factory UserInformationModel.fromJson(Map<String, dynamic> json) =>
      UserInformationModel(
        code: json["code"],
        status: json["status"],
        data: UserById.fromJson(json["data"]),
      );
}

class UserById {
  int id;
  String email;
  String? username;
  UserInfor? userInfor;
  Role? role;
  int? provinceId;
  String? image;
  int? classId;
  ProvinceClass? province;
  Class dataClass;

  UserById({
    this.id = 0,
    this.email = "no-email",
    this.userInfor,
    this.username,
    this.role,
    this.province,
    this.image,
    this.classId,
    required this.dataClass,
    this.provinceId,
  });

  factory UserById.fromJson(Map<String, dynamic> json) => UserById(
      id: json["id"],
      email: json["email"],
       dataClass: Class.fromJson(json["class"]),
      username: json['username'],
      image: json["image"],
      userInfor: json["user_infor"] == null
          ? null
          : UserInfor.fromJson(json["user_infor"]),
      role: Role.fromJson(json["role"]),
      classId: json['class_Id'] ?? 0,
      province: ProvinceClass.fromJson(json['province']),
      provinceId: json['province_id'] ?? 0);
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
  int? idClass;
  Year? getYear;
  String phone;
  Class? className;
  String? lat;
  String? long;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserInfor({
    this.id = 0,
    this.name,
    this.idClass,
    this.getYear,
    this.codeId = "no-codeId",
    this.age = "no-age",
    this.sex = "no-sex",
    this.className,
    this.city = "no-city",
    this.khan = "no-Khan",
    this.sangkat = "no-sangkat",
    this.image = "no-image",
    this.country = "no-coutry",
    this.phone = "no-phone",
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfor.fromJson(Map<String, dynamic> json) => UserInfor(
        id: json["id"],
        name: json["name"] ?? "",
        codeId: json["codeId"],
        age: json["age"],
        sex: json["sex"],
        idClass: json["id_class"] ?? 0,
        city: json["city"],
        getYear:
            json["get_year"] == null ? null : Year.fromJson(json["get_year"]),
        khan: json["khan"],
        sangkat: json["sangkat"],
        image: json["image"],
        country: json["country"],
        className: json["get_class"] == null
            ? null
            : Class.fromJson(json["get_class"]),
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lat: json["lat"],
        long: json["long"]
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

class ProvinceClass {
  int id;
  String nameProvince;
  ProvinceClass({this.id = 0, this.nameProvince = "no-province"});
  factory ProvinceClass.fromJson(Map<String, dynamic> json) => ProvinceClass(
        id: json["id"],
        nameProvince: json["name_province"],
      );
}

class Year {
  int id;
  String year;

  Year({
    required this.id,
    required this.year,
  });

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"],
        year: json["year"],
      );
}
