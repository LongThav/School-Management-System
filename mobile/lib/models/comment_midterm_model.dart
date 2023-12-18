class CommentMidtermModel {
  int code;
  String status;
  Midterm midterm;

  CommentMidtermModel({
    this.code = 9,
    this.status = "no-status",
    required this.midterm,
  });

  factory CommentMidtermModel.fromJson(Map<String, dynamic> json) =>
      CommentMidtermModel(
        code: json["code"],
        status: json["status"],
        midterm: Midterm.fromJson(json["data"]),
      );
}

class Midterm {
  int id;
  String title;
  String? image;
  List<Cmt> cmt;

  Midterm({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.cmt = const [],
  });

  factory Midterm.fromJson(Map<String, dynamic> json) => Midterm(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        cmt: List<Cmt>.from(json["cmt"].map((x) => Cmt.fromJson(x))),
      );
}

class Cmt {
  int id;
  String title;
  String? image;
  Cmt({
    this.id = 0,
    this.title = "no-title",
    this.image,
  });

  factory Cmt.fromJson(Map<String, dynamic> json) => Cmt(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );
}
