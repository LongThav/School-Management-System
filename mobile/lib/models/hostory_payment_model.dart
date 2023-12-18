class HistoryPaymentModel {
  int code;
  String status;
  Data data;

  HistoryPaymentModel({
    this.code = 0,
    this.status = "no-status",
    required this.data,
  });

  factory HistoryPaymentModel.fromJson(Map<String, dynamic> json) =>
      HistoryPaymentModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int id;
  List<Payment> payments;
  List<dynamic> userAccounts;
  Data({
    this.id = 0,
    this.payments = const [],
    this.userAccounts = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
        userAccounts: List<dynamic>.from(json["user_accounts"].map((x) => x)),
      );
}

class ClassId {
  int id;
  String majorName;
  int yearId;

  ClassId({
    required this.id,
    required this.majorName,
    required this.yearId,
  });

  factory ClassId.fromJson(Map<String, dynamic> json) => ClassId(
        id: json["id"],
        majorName: json["major_name"],
        yearId: json["year_id"],
      );
}

class ClassName {
  int id;
  String nameClass;

  ClassName({
    required this.id,
    required this.nameClass,
  });

  factory ClassName.fromJson(Map<String, dynamic> json) => ClassName(
        id: json["id"],
        nameClass: json["name_class"],
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

class Payment {
  int id;
  int personId;
  String totalPayment;
  Payment({
    required this.id,
    required this.personId,
    required this.totalPayment,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        personId: json["person_id"],
        totalPayment: json["total_payment"],
      );
}

class Province {
  int id;
  String nameProvince;

  Province({
    required this.id,
    required this.nameProvince,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
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
